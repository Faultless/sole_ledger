import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/common.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/tax/depreciation.dart';
import '../../l10n/app_localizations.dart';
import '../shell/app_shell.dart';

/// Fixed-asset register (固定資産台帳): assets whose cost is deducted over time
/// via depreciation, feeding the tax set-aside and annual report.
class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});

  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen> {
  bool _selecting = false;
  final Set<String> _selected = {};

  void _enterSelection(String id) {
    setState(() {
      _selecting = true;
      _selected.add(id);
    });
  }

  void _toggle(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
        if (_selected.isEmpty) _selecting = false;
      } else {
        _selected.add(id);
      }
    });
  }

  void _exitSelection() {
    setState(() {
      _selecting = false;
      _selected.clear();
    });
  }

  Future<void> _deleteSelected(L10n l10n) async {
    final ok = await confirmDeleteDialog(
      context,
      message: l10n.commonDeleteCountConfirm(_selected.length),
      cancelLabel: l10n.commonCancel,
      deleteLabel: l10n.commonDelete,
    );
    if (!ok || !mounted) return;
    await ref.read(repositoryProvider).deleteAssets(_selected.toList());
    if (mounted) _exitSelection();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final assets = ref.watch(assetsProvider).value ?? const [];
    final year = DateTime.now().year;

    // This year's total deductible depreciation, per currency (for the header).
    final byCur = <Currency, int>{};
    for (final a in assets) {
      final ded = Depreciation.deductibleForYear(
        costMinor: a.costMinor,
        acquisition: a.acquisitionDate,
        method: DepreciationMethod.fromName(a.method),
        usefulLifeYears: a.usefulLifeYears,
        businessUsePercent: a.businessUsePercent,
        year: year,
      );
      if (ded == 0) continue;
      final c = Currency.fromCode(a.currency);
      byCur.update(c, (v) => v + ded, ifAbsent: () => ded);
    }
    final headerText = byCur.entries
        .map((e) => fmt.money(Money(e.value, e.key)))
        .join(' · ');

    return Scaffold(
      appBar: _selecting
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _exitSelection,
              ),
              title: Text(l10n.commonSelectedCount(_selected.length)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.select_all),
                  tooltip: l10n.commonSelectAll,
                  onPressed: () =>
                      setState(() => _selected.addAll(assets.map((a) => a.id))),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed:
                      _selected.isEmpty ? null : () => _deleteSelected(l10n),
                ),
              ],
            )
          : AppBar(
              leading: navLeading(context),
              title: const Text('Fixed assets'),
              actions: [
                if (assets.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.checklist),
                    tooltip: l10n.commonSelect,
                    onPressed: () => setState(() => _selecting = true),
                  ),
              ],
              bottom: byCur.isEmpty
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(34),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                          child: Text('$year depreciation: $headerText',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant)),
                        ),
                      ),
                    ),
            ),
      floatingActionButton: _selecting
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openEditor(context, null),
              icon: const Icon(Icons.add),
              label: const Text('Add asset'),
            ),
      body: SafeArea(
        child: assets.isEmpty
            ? const _AssetsEmpty()
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                itemCount: assets.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final a = assets[i];
                  final c = Currency.fromCode(a.currency);
                  final method = DepreciationMethod.fromName(a.method);
                  final thisYear = Depreciation.deductibleForYear(
                    costMinor: a.costMinor,
                    acquisition: a.acquisitionDate,
                    method: method,
                    usefulLifeYears: a.usefulLifeYears,
                    businessUsePercent: a.businessUsePercent,
                    year: year,
                  );
                  final book = Depreciation.bookValueAtEndOf(
                    costMinor: a.costMinor,
                    acquisition: a.acquisitionDate,
                    method: method,
                    usefulLifeYears: a.usefulLifeYears,
                    year: year,
                  );
                  final selected = _selected.contains(a.id);
                  final tile = ListTile(
                    leading: _selecting
                        ? Checkbox(
                            value: selected,
                            onChanged: (_) => _toggle(a.id),
                          )
                        : CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child:
                                const Icon(Icons.inventory_2_outlined, size: 18),
                          ),
                    title: Text(a.description.isEmpty ? 'Asset' : a.description),
                    subtitle: Text([
                      fmt.money(Money(a.costMinor, c)),
                      _methodShort(method),
                      '${a.acquisitionDate.year}',
                      if (a.businessUsePercent != 100) '${a.businessUsePercent}%',
                    ].join(' · ')),
                    trailing: _selecting
                        ? null
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('$year: ${fmt.money(Money(thisYear, c))}',
                                  style: Theme.of(context).textTheme.titleSmall),
                              Text('book ${fmt.money(Money(book, c))}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant)),
                            ],
                          ),
                    selected: selected,
                    onTap: _selecting
                        ? () => _toggle(a.id)
                        : () => _openEditor(context, a),
                    onLongPress:
                        _selecting ? null : () => _enterSelection(a.id),
                  );
                  if (_selecting) return tile;
                  return Dismissible(
                    key: ValueKey(a.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: const Icon(Icons.delete_outline),
                    ),
                    onDismissed: (_) =>
                        ref.read(repositoryProvider).deleteAsset(a.id),
                    child: tile,
                  );
                },
              ),
      ),
    );
  }

  void _openEditor(BuildContext context, Asset? asset) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _AssetEditor(asset: asset),
    );
  }
}

String _methodShort(DepreciationMethod m) => switch (m) {
      DepreciationMethod.fullExpense => '少額特例',
      DepreciationMethod.lumpThreeYear => '一括償却',
      DepreciationMethod.straightLine => '定額法',
    };

class _AssetsEmpty extends StatelessWidget {
  const _AssetsEmpty();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 48, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text('No assets yet',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Add equipment costing ¥100,000 or more (laptops, monitors). '
              'Its cost is deducted over several years via depreciation, not all '
              'at once — this register tracks that for your tax estimate.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetEditor extends ConsumerStatefulWidget {
  const _AssetEditor({this.asset});
  final Asset? asset;
  @override
  ConsumerState<_AssetEditor> createState() => _AssetEditorState();
}

class _AssetEditorState extends ConsumerState<_AssetEditor> {
  late DateTime _date = widget.asset?.acquisitionDate ?? DateTime.now();
  late String _currency = widget.asset?.currency ?? 'JPY';
  late DepreciationMethod _method =
      DepreciationMethod.fromName(widget.asset?.method ?? 'straightLine');
  late int _businessUse = widget.asset?.businessUsePercent ?? 100;
  late final _desc =
      TextEditingController(text: widget.asset?.description ?? '');
  late final _cost = TextEditingController(
      text: widget.asset == null
          ? ''
          : Money(widget.asset!.costMinor,
                  Currency.fromCode(widget.asset!.currency))
              .asMajor
              .toString());
  late final _life =
      TextEditingController(text: '${widget.asset?.usefulLifeYears ?? 4}');

  Currency get _cur => Currency.fromCode(_currency);
  Money get _costMoney => Money.fromMajor(
      double.tryParse(_cost.text.replaceAll(',', '.').trim()) ?? 0, _cur);

  @override
  void dispose() {
    _desc.dispose();
    _cost.dispose();
    _life.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final cost = _costMoney;
    if (cost.isZero) return;
    final repo = ref.read(repositoryProvider);
    await repo.upsertAsset(AssetsCompanion(
      id: Value(widget.asset?.id ?? repo.newId()),
      description: Value(_desc.text.trim()),
      acquisitionDate: Value(DateTime(_date.year, _date.month, _date.day)),
      costMinor: Value(cost.minorUnits),
      currency: Value(_currency),
      method: Value(_method.name),
      usefulLifeYears: Value(int.tryParse(_life.text.trim()) ?? 4),
      businessUsePercent: Value(_businessUse),
    ));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final fmt = ref.watch(formattersProvider);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final firstYear = Depreciation.deductibleForYear(
      costMinor: _costMoney.minorUnits,
      acquisition: DateTime(_date.year, _date.month, _date.day),
      method: _method,
      usefulLifeYears: int.tryParse(_life.text.trim()) ?? 4,
      businessUsePercent: _businessUse,
      year: _date.year,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.asset == null ? 'Add asset' : 'Edit asset',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              controller: _desc,
              decoration: const InputDecoration(
                  labelText: 'Description (e.g. MacBook Pro)'),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                  icon: const Icon(Icons.calendar_today, size: 18),
                  label: Text(fmt.date(_date)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _currency,
                  decoration: const InputDecoration(labelText: 'Currency'),
                  items: [
                    for (final c in Currency.values)
                      DropdownMenuItem(
                          value: c.code, child: Text('${c.symbol} ${c.code}')),
                  ],
                  onChanged: (v) => setState(() => _currency = v ?? 'JPY'),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            TextField(
              controller: _cost,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Acquisition cost'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<DepreciationMethod>(
              initialValue: _method,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Method'),
              items: const [
                DropdownMenuItem(
                  value: DepreciationMethod.straightLine,
                  child: Text('Straight-line (定額法)',
                      overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: DepreciationMethod.fullExpense,
                  child: Text('Full write-off < ¥300k (少額特例)',
                      overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: DepreciationMethod.lumpThreeYear,
                  child: Text('Even over 3 years (一括償却)',
                      overflow: TextOverflow.ellipsis),
                ),
              ],
              onChanged: (v) =>
                  setState(() => _method = v ?? DepreciationMethod.straightLine),
            ),
            if (_method == DepreciationMethod.straightLine) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _life,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Useful life (years)',
                    helperText: 'e.g. laptop 4, monitor 5, desk 8'),
                onChanged: (_) => setState(() {}),
              ),
            ],
            const SizedBox(height: 16),
            Row(children: [
              const Text('Business use · 家事按分'),
              const Spacer(),
              Text('$_businessUse%',
                  style: Theme.of(context).textTheme.titleMedium),
            ]),
            Slider(
              value: _businessUse.toDouble(),
              min: 0,
              max: 100,
              divisions: 20,
              label: '$_businessUse%',
              onChanged: (v) => setState(() => _businessUse = v.round()),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Expanded(
                  child: Text(
                    'Deductible in ${_date.year} (first year)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(fmt.money(Money(firstYear, _cur)),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary)),
              ]),
            ),
            const SizedBox(height: 8),
            Text(
              'The cost is spread across years; only the slice above counts this '
              'year. Estimate — confirm the useful life and method with your 税理士.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
