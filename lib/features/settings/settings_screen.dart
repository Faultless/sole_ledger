import 'package:drift/drift.dart' show Value;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money/currency.dart';
import '../../core/widgets/common.dart';
import '../../data/db/database.dart';
import '../../data/db/db_location.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../l10n/app_localizations.dart';
import '../shell/app_shell.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _controllers = <String, TextEditingController>{};
  String _currency = 'EUR';
  bool _seeded = false;
  Future<String?> _dbPath = currentDatabasePath();
  bool _justEnabledSync = false;

  TextEditingController _c(String key) =>
      _controllers.putIfAbsent(key, () => TextEditingController());

  void _seed(BusinessProfile p) {
    _c('tradeName').text = p.tradeName;
    _c('legalName').text = p.legalName;
    _c('kvk').text = p.kvkNumber;
    _c('vatId').text = p.vatId;
    _c('jpNo').text = p.jpBusinessNumber;
    _c('email').text = p.email;
    _c('phone').text = p.phone;
    _c('addr1').text = p.addressLine1;
    _c('addr2').text = p.addressLine2;
    _c('postal').text = p.postalCode;
    _c('city').text = p.city;
    _c('country').text = p.country;
    _c('iban').text = p.iban;
    _c('bic').text = p.bic;
    _c('bank').text = p.bankName;
    _c('prefix').text = p.invoiceNumberPrefix;
    _c('rate').text = p.defaultHourlyRate == 0
        ? ''
        : p.defaultHourlyRate.toString();
    _c('fxRate').text = p.eurToJpyRate.toStringAsFixed(0);
    _currency = p.defaultCurrency;
    _seeded = true;
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final repo = ref.read(repositoryProvider);
    await repo.saveBusinessProfile(BusinessProfilesCompanion(
      tradeName: Value(_c('tradeName').text.trim()),
      legalName: Value(_c('legalName').text.trim()),
      kvkNumber: Value(_c('kvk').text.trim()),
      vatId: Value(_c('vatId').text.trim()),
      jpBusinessNumber: Value(_c('jpNo').text.trim()),
      email: Value(_c('email').text.trim()),
      phone: Value(_c('phone').text.trim()),
      addressLine1: Value(_c('addr1').text.trim()),
      addressLine2: Value(_c('addr2').text.trim()),
      postalCode: Value(_c('postal').text.trim()),
      city: Value(_c('city').text.trim()),
      country: Value(_c('country').text.trim()),
      iban: Value(_c('iban').text.trim()),
      bic: Value(_c('bic').text.trim()),
      bankName: Value(_c('bank').text.trim()),
      invoiceNumberPrefix: Value(_c('prefix').text.trim().isEmpty
          ? 'INV'
          : _c('prefix').text.trim()),
      defaultCurrency: Value(_currency),
      defaultHourlyRate:
          Value(double.tryParse(_c('rate').text.trim()) ?? 0),
      eurToJpyRate: Value(
          double.tryParse(_c('fxRate').text.replaceAll(',', '.').trim()) ?? 160),
    ));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context).commonSave)),
      );
    }
  }

  Future<void> _setLanguage(AppLanguage lang) async {
    await ref.read(repositoryProvider).saveBusinessProfile(
          BusinessProfilesCompanion(defaultLanguage: Value(lang.code)),
        );
  }

  Future<void> _setTheme(String mode) async {
    await ref.read(repositoryProvider).saveBusinessProfile(
          BusinessProfilesCompanion(themeMode: Value(mode)),
        );
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _exportBackup() async {
    try {
      // Flush the WAL into the main file so the backup is consistent.
      await ref
          .read(databaseProvider)
          .customStatement('PRAGMA wal_checkpoint(TRUNCATE)');
      final bytes = await readDatabaseBytes();
      if (bytes == null) {
        _snack(
            'Backup isn\'t available here (web keeps data inside the browser). '
            'Use the desktop app to export.');
        return;
      }
      final now = DateTime.now();
      final stamp =
          '${now.year}${_two(now.month)}${_two(now.day)}';
      await FileSaver.instance.saveFile(
        name: 'sole_ledger-backup-$stamp',
        bytes: bytes,
        fileExtension: 'sqlite',
        mimeType: MimeType.other,
      );
      _snack('Backup saved.');
    } catch (e) {
      _snack('Export failed: $e');
    }
  }

  String _two(int v) => v < 10 ? '0$v' : '$v';

  Future<void> _confirmReset() async {
    final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Reset all data?'),
            content: const Text(
              'This permanently deletes every client, project, time entry, '
              'invoice, expense and asset on this device. It cannot be undone, '
              'and if sync is enabled the deletion will propagate to your other '
              'devices. Export a backup first if unsure.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(ctx).colorScheme.error),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Delete everything'),
              ),
            ],
          ),
        ) ??
        false;
    if (!ok) return;
    final repo = ref.read(repositoryProvider);
    await repo.deleteAllData();
    await repo.ensureBusinessProfile(); // seed a fresh default profile
    if (mounted) {
      setState(() => _seeded = false); // re-seed the form from the new profile
      _snack('All data cleared.');
    }
  }

  Widget _manageDataCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: _exportBackup,
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text('Export backup (.sqlite)'),
            ),
            const SizedBox(height: 6),
            Text(
              'Saves a copy of the whole ledger as a single file you can archive '
              'or move between devices.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant),
            ),
            const Divider(height: 28),
            OutlinedButton.icon(
              onPressed: _confirmReset,
              icon: Icon(Icons.delete_forever_outlined,
                  size: 18, color: scheme.error),
              style: OutlinedButton.styleFrom(
                foregroundColor: scheme.error,
                side: BorderSide(color: scheme.error.withValues(alpha: 0.5)),
              ),
              label: const Text('Reset all data'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final profile = ref.watch(businessProfileProvider).value;
    final currentLang = ref.watch(appLanguageProvider);
    if (profile != null && !_seeded) _seed(profile);

    return Scaffold(
      appBar: AppBar(
        leading: navLeading(context),
        title: Text(l10n.settingsTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(l10n.commonSave),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SectionHeader(title: 'Appearance'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: 'system', label: Text('System')),
                    ButtonSegment(value: 'light', label: Text('Light')),
                    ButtonSegment(value: 'dark', label: Text('Dark')),
                  ],
                  selected: {profile?.themeMode ?? 'system'},
                  onSelectionChanged: (s) => _setTheme(s.first),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(title: l10n.settingsLanguage),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SegmentedButton<AppLanguage>(
                  segments: [
                    for (final lang in AppLanguage.values)
                      ButtonSegment(
                          value: lang, label: Text(lang.code.toUpperCase())),
                  ],
                  selected: {currentLang},
                  onSelectionChanged: (s) => _setLanguage(s.first),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(title: 'Currencies & rates'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _currency,
                      decoration:
                          const InputDecoration(labelText: 'Default currency'),
                      items: [
                        for (final c in Currency.values)
                          DropdownMenuItem(
                              value: c.code,
                              child: Text('${c.symbol} ${c.code}')),
                      ],
                      onChanged: (v) => setState(() => _currency = v ?? 'EUR'),
                    ),
                    const SizedBox(height: 12),
                    _field('fxRate', 'EUR → JPY rate (for tax estimates)',
                        number: true),
                    const SizedBox(height: 8),
                    Text(
                      'Invoices, expenses and reports use EUR, JPY and USD. The '
                      'EUR→JPY rate converts profit for the Japanese tax estimate. '
                      'Tap Save to apply.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(title: l10n.settingsBusinessProfile),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _field('tradeName', 'Trade name'),
                    _field('legalName', 'Legal name'),
                    Row(children: [
                      Expanded(child: _field('kvk', l10n.invoiceKvk)),
                      const SizedBox(width: 12),
                      Expanded(child: _field('vatId', l10n.invoiceVatId)),
                    ]),
                    _field('jpNo', 'JP invoice reg. no. (適格請求書)'),
                    const Divider(height: 28),
                    _field('addr1', 'Address line 1'),
                    _field('addr2', 'Address line 2'),
                    Row(children: [
                      Expanded(child: _field('postal', 'Postal code')),
                      const SizedBox(width: 12),
                      Expanded(flex: 2, child: _field('city', 'City')),
                    ]),
                    _field('country', 'Country'),
                    Row(children: [
                      Expanded(child: _field('email', 'Email')),
                      const SizedBox(width: 12),
                      Expanded(child: _field('phone', 'Phone')),
                    ]),
                    const Divider(height: 28),
                    _field('bank', 'Bank name'),
                    Row(children: [
                      Expanded(flex: 2, child: _field('iban', 'IBAN')),
                      const SizedBox(width: 12),
                      Expanded(child: _field('bic', 'BIC/SWIFT')),
                    ]),
                    const Divider(height: 28),
                    Row(children: [
                      Expanded(child: _field('prefix', 'Invoice prefix')),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _field('rate', 'Default hourly rate',
                              number: true)),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.info_outline, size: 18),
                      const SizedBox(width: 8),
                      Text(l10n.settingsTaxDisclaimerTitle,
                          style: Theme.of(context).textTheme.titleSmall),
                    ]),
                    const SizedBox(height: 8),
                    Text(l10n.settingsTaxDisclaimer,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(title: 'Data & sync'),
            _dataSyncCard(context),
            const SizedBox(height: 16),
            SectionHeader(title: 'Manage data'),
            _manageDataCard(context),
          ],
        ),
      ),
    );
  }

  Future<void> _enableSync() async {
    final granted = await enableExternalSync();
    if (!mounted) return;
    if (granted) {
      setState(() {
        _dbPath = currentDatabasePath();
        _justEnabledSync = true;
      });
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Sync folder enabled'),
          content: const Text(
            'Your ledger has been copied to the shared SoleLedger folder. '
            'Fully close and reopen the app so it loads from there, then point '
            'Syncthing at that folder.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('"All files access" was not granted — sync not enabled'),
        ),
      );
    }
  }

  Widget _dataSyncCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<String?>(
          future: _dbPath,
          builder: (context, snap) {
            final path = snap.data;
            final theme = Theme.of(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(Icons.storage_outlined, size: 18),
                  const SizedBox(width: 8),
                  Text('Database location',
                      style: theme.textTheme.titleSmall),
                ]),
                const SizedBox(height: 8),
                if (path != null) ...[
                  SelectableText(path,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontFamily: 'monospace')),
                  const SizedBox(height: 8),
                  Row(children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: path));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Path copied')),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copy path'),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  if (_justEnabledSync)
                    Text(
                      'Restart the app to start using this folder.',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  Text(
                    'Point Syncthing at this folder to keep your ledger in sync '
                    'across devices. Edit on one device at a time and let sync '
                    'settle before switching — SQLite files can\'t be merged.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ] else ...[
                  Text(
                    'This build stores data in its own private storage '
                    '(browser storage on web, app storage on mobile), which a '
                    'file syncer can\'t reach.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  if (canEnableExternalSync) ...[
                    const SizedBox(height: 12),
                    FilledButton.tonalIcon(
                      onPressed: _enableSync,
                      icon: const Icon(Icons.sync, size: 18),
                      label: const Text('Enable sync folder'),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Grants "All files access" and copies the ledger to a '
                      'shared SoleLedger folder Syncthing can read. Restart the '
                      'app afterwards.',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _field(String key, String label, {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _c(key),
        keyboardType: number
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
