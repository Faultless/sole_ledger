import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money/currency.dart';
import '../../core/widgets/common.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _controllers = <String, TextEditingController>{};
  String _currency = 'EUR';
  bool _seeded = false;

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

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final profile = ref.watch(businessProfileProvider).value;
    final currentLang = ref.watch(appLanguageProvider);
    if (profile != null && !_seeded) _seed(profile);

    return Scaffold(
      appBar: AppBar(
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
            SectionHeader(title: l10n.settingsLanguage),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SegmentedButton<AppLanguage>(
                  segments: [
                    for (final lang in AppLanguage.values)
                      ButtonSegment(value: lang, label: Text(lang.nativeName)),
                  ],
                  selected: {currentLang},
                  onSelectionChanged: (s) => _setLanguage(s.first),
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
                        child: DropdownButtonFormField<String>(
                          initialValue: _currency,
                          decoration:
                              const InputDecoration(labelText: 'Default currency'),
                          items: [
                            for (final c in Currency.values)
                              DropdownMenuItem(
                                  value: c.code, child: Text('${c.symbol} ${c.code}')),
                          ],
                          onChanged: (v) => setState(() => _currency = v ?? 'EUR'),
                        ),
                      ),
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
          ],
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
