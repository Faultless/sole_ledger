import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/common.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/tax/expense_categories.dart';
import '../../l10n/app_localizations.dart';
import '../shell/app_shell.dart';
import 'receipt_image.dart';
import 'receipt_ocr.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final lang = ref.watch(appLanguageProvider).code;
    final fmt = ref.watch(formattersProvider);
    final expenses = ref.watch(expensesProvider).value ?? const [];

    // Year-to-date deductible total per currency (after 家事按分), for the header.
    final now = DateTime.now();
    final ytd = <Currency, int>{};
    for (final e in expenses) {
      if (e.date.year != now.year) continue;
      final ded = deductibleMinorOf(
        deductible: e.deductible,
        amountMinor: e.amountMinor,
        businessUsePercent: e.businessUsePercent,
      );
      if (ded == 0) continue;
      final c = Currency.fromCode(e.currency);
      ytd.update(c, (v) => v + ded, ifAbsent: () => ded);
    }
    final ytdText =
        ytd.entries.map((e) => fmt.money(Money(e.value, e.key))).join(' · ');

    return Scaffold(
      appBar: AppBar(
        leading: navLeading(context),
        title: Text(l10n.navExpenses),
        bottom: ytd.isEmpty
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(34),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Text('${now.year} · ${l10n.expenseDeductible}: $ytdText',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant)),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.commonAdd),
      ),
      body: SafeArea(
        child: expenses.isEmpty
            ? EmptyState(icon: Icons.payments_outlined, message: l10n.commonEmpty)
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                itemCount: expenses.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final e = expenses[i];
                  final currency = Currency.fromCode(e.currency);
                  final cat = expenseCategoryByCode(e.category);
                  return Dismissible(
                    key: ValueKey(e.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: const Icon(Icons.delete_outline),
                    ),
                    onDismissed: (_) =>
                        ref.read(repositoryProvider).deleteExpense(e.id),
                    child: ListTile(
                      leading: e.receiptImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(e.receiptImage!,
                                  width: 40, height: 40, fit: BoxFit.cover),
                            )
                          : CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              child: Icon(_categoryIcon(e.category), size: 18),
                            ),
                      title: Text(
                          e.description.isEmpty ? cat.labelFor(lang) : e.description),
                      subtitle: Text([
                        cat.labelFor(lang),
                        fmt.date(e.date),
                        if (e.businessUsePercent != 100) '${e.businessUsePercent}%',
                        if (!e.deductible) '${l10n.expenseDeductible}: —',
                      ].join(' · ')),
                      trailing: Text(fmt.money(Money(e.amountMinor, currency)),
                          style: Theme.of(context).textTheme.titleMedium),
                      onTap: () => _openEditor(context, e),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _openEditor(BuildContext context, Expense? expense) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ExpenseEditor(expense: expense),
    );
  }
}

IconData _categoryIcon(String category) => switch (category) {
      'software' => Icons.code,
      'communication' => Icons.wifi,
      'travel' => Icons.flight,
      'entertainment' => Icons.restaurant,
      'meeting' => Icons.groups_outlined,
      'rent' => Icons.home_work_outlined,
      'utilities' => Icons.bolt_outlined,
      'books' => Icons.menu_book_outlined,
      'advertising' => Icons.campaign_outlined,
      'outsourcing' => Icons.handshake_outlined,
      'fees' => Icons.account_balance,
      'depreciation' => Icons.trending_down,
      'taxes' => Icons.receipt_long_outlined,
      'supplies' => Icons.inventory_2_outlined,
      _ => Icons.more_horiz,
    };

class _ExpenseEditor extends ConsumerStatefulWidget {
  const _ExpenseEditor({this.expense});
  final Expense? expense;
  @override
  ConsumerState<_ExpenseEditor> createState() => _ExpenseEditorState();
}

class _ExpenseEditorState extends ConsumerState<_ExpenseEditor> {
  late DateTime _date = widget.expense?.date ?? DateTime.now();
  late String _category = widget.expense?.category ?? 'supplies';
  late String _currency = widget.expense?.currency ?? 'JPY';
  late int _businessUse = widget.expense?.businessUsePercent ??
      expenseCategoryByCode(_category).defaultBusinessUsePercent;
  int _vatRate = 0;
  late final _desc =
      TextEditingController(text: widget.expense?.description ?? '');
  late final _amount = TextEditingController(
      text: widget.expense == null
          ? ''
          : Money(widget.expense!.amountMinor,
                  Currency.fromCode(widget.expense!.currency))
              .asMajor
              .toString());
  late final _vat = TextEditingController(
      text: widget.expense == null || widget.expense!.vatMinor == 0
          ? ''
          : Money(widget.expense!.vatMinor,
                  Currency.fromCode(widget.expense!.currency))
              .asMajor
              .toString());
  late bool _deductible = widget.expense?.deductible ?? true;
  late Uint8List? _receiptBytes = widget.expense?.receiptImage;
  late String? _receiptMime = widget.expense?.receiptMime;
  bool _fromScan = false;
  bool _busy = false;

  Currency get _cur => Currency.fromCode(_currency);
  Money get _amountMoney => Money.fromMajor(
      double.tryParse(_amount.text.replaceAll(',', '.').trim()) ?? 0, _cur);

  @override
  void dispose() {
    _desc.dispose();
    _amount.dispose();
    _vat.dispose();
    super.dispose();
  }

  void _onCategory(String code) {
    setState(() {
      _category = code;
      // Adopt the category's default apportionment (only when adding fresh).
      if (widget.expense == null) {
        _businessUse = expenseCategoryByCode(code).defaultBusinessUsePercent;
      }
    });
  }

  void _recomputeVatFromGross() {
    if (_vatRate <= 0) return;
    final vat = _amountMoney.vatPortionFromGross(_vatRate);
    _vat.text = vat.isZero ? '' : vat.asMajor.toString();
  }

  /// Picks a receipt from [source], stores it, and — when [runOcr] and the
  /// platform supports OCR — reads it to pre-fill the fields.
  Future<void> _addReceipt(ImageSource source, {required bool runOcr}) async {
    setState(() => _busy = true);
    try {
      final picked = await pickReceipt(source);
      if (picked == null) return; // cancelled
      if (!mounted) return;
      setState(() {
        _receiptBytes = picked.bytes;
        _receiptMime = picked.mime;
        _fromScan = false;
      });
      if (runOcr && ocrSupported) {
        final scan = await scanReceipt(picked);
        if (!mounted) return;
        if (scan == null || scan.isEmpty) {
          _snack(L10n.of(context).receiptScanNothing);
        } else {
          _applyScan(scan);
        }
      }
    } catch (e) {
      if (mounted) _snack('$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Copies best-effort scanned values into the editor fields, leaving anything
  /// the parser wasn't sure about untouched. Flags the form as scan-derived so
  /// the user is prompted to verify.
  void _applyScan(ScannedReceipt s) {
    setState(() {
      _fromScan = true;
      if (s.currency != null) _currency = s.currency!;
      if (s.date != null) _date = s.date!;
      if (s.vatRate != null) _vatRate = s.vatRate!;
      if (s.amountMajor != null) {
        _amount.text = _formatMajor(s.amountMajor!, _cur);
      }
      if (s.vatMajor != null) {
        _vat.text = _formatMajor(s.vatMajor!, _cur);
      } else if (s.amountMajor != null && _vatRate > 0) {
        _recomputeVatFromGross();
      }
      if (_desc.text.trim().isEmpty && s.vendor != null) {
        _desc.text = s.vendor!;
      }
    });
  }

  String _formatMajor(double value, Currency cur) =>
      cur.decimals == 0 ? value.round().toString() : value.toStringAsFixed(cur.decimals);

  void _snack(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _viewReceipt() {
    final bytes = _receiptBytes;
    if (bytes == null) return;
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => Navigator.of(ctx).pop(),
          child: InteractiveViewer(
            child: Image.memory(bytes, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptSection(BuildContext context, L10n l10n) {
    final scheme = Theme.of(context).colorScheme;
    final bytes = _receiptBytes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          if (bytes != null) ...[
            InkWell(
              onTap: _viewReceipt,
              borderRadius: BorderRadius.circular(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(bytes,
                    width: 52, height: 68, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextButton.icon(
                onPressed: _busy
                    ? null
                    : () => setState(() {
                          _receiptBytes = null;
                          _receiptMime = null;
                          _fromScan = false;
                        }),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: Text(l10n.receiptRemove),
                style: TextButton.styleFrom(
                    alignment: AlignmentDirectional.centerStart),
              ),
            ),
          ] else if (_busy)
            Expanded(
              child: Row(children: [
                const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
                const SizedBox(width: 12),
                Text(l10n.receiptScanning),
              ]),
            )
          else if (ocrSupported) ...[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    _addReceipt(ImageSource.camera, runOcr: true),
                icon: const Icon(Icons.document_scanner_outlined, size: 18),
                label: Text(l10n.receiptScan),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    _addReceipt(ImageSource.gallery, runOcr: true),
                icon: const Icon(Icons.photo_library_outlined, size: 18),
                label: Text(l10n.receiptAttach),
              ),
            ),
          ] else
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    _addReceipt(ImageSource.gallery, runOcr: false),
                icon: const Icon(Icons.attach_file, size: 18),
                label: Text(l10n.receiptAttach),
              ),
            ),
        ]),
        if (_fromScan) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: scheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              Icon(Icons.fact_check_outlined,
                  size: 18, color: scheme.onTertiaryContainer),
              const SizedBox(width: 8),
              Expanded(
                child: Text(l10n.receiptFromScanVerify,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onTertiaryContainer)),
              ),
            ]),
          ),
        ],
      ],
    );
  }

  Future<void> _save() async {
    final amount = _amountMoney;
    if (amount.isZero) return;
    final vat = Money.fromMajor(
        double.tryParse(_vat.text.replaceAll(',', '.').trim()) ?? 0, _cur);
    final repo = ref.read(repositoryProvider);
    await repo.upsertExpense(ExpensesCompanion(
      id: Value(widget.expense?.id ?? repo.newId()),
      date: Value(DateTime(_date.year, _date.month, _date.day)),
      category: Value(_category),
      description: Value(_desc.text.trim()),
      amountMinor: Value(amount.minorUnits),
      vatMinor: Value(vat.minorUnits),
      currency: Value(_currency),
      deductible: Value(_deductible),
      businessUsePercent: Value(_businessUse),
      receiptImage: Value(_receiptBytes),
      receiptMime: Value(_receiptMime),
    ));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final lang = ref.watch(appLanguageProvider).code;
    final fmt = ref.watch(formattersProvider);
    final cat = expenseCategoryByCode(_category);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final deductible = Money(
      deductibleMinorOf(
        deductible: _deductible,
        amountMinor: _amountMoney.minorUnits,
        businessUsePercent: _businessUse,
      ),
      _cur,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.expense == null ? l10n.commonAdd : l10n.commonEdit,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildReceiptSection(context, l10n),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
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
                  initialValue: _category,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: l10n.expenseCategory),
                  items: [
                    for (final c in expenseCategories)
                      DropdownMenuItem(
                        value: c.code,
                        child: Text('${c.labelFor(lang)} · ${c.account}',
                            overflow: TextOverflow.ellipsis),
                      ),
                  ],
                  onChanged: (v) => _onCategory(v ?? 'supplies'),
                ),
              ),
            ]),
            if (cat.hintFor(lang).isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.lightbulb_outline,
                    size: 15, color: Theme.of(context).colorScheme.tertiary),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(cat.hintFor(lang),
                        style: Theme.of(context).textTheme.bodySmall)),
              ]),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: _desc,
              decoration: InputDecoration(labelText: l10n.invoiceDescription),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _currency,
                  decoration: InputDecoration(labelText: l10n.commonCurrency),
                  items: [
                    for (final c in Currency.values)
                      DropdownMenuItem(
                          value: c.code, child: Text('${c.symbol} ${c.code}')),
                  ],
                  onChanged: (v) => setState(() {
                    _currency = v ?? 'JPY';
                    _recomputeVatFromGross();
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _amount,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      labelText: l10n.expenseAmount, helperText: 'incl. VAT'),
                  onChanged: (_) => setState(_recomputeVatFromGross),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: _vatRate,
                  decoration: const InputDecoration(labelText: 'VAT rate'),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('— / manual')),
                    DropdownMenuItem(value: 8, child: Text('8% 軽減')),
                    DropdownMenuItem(value: 10, child: Text('10% 消費税')),
                    DropdownMenuItem(value: 21, child: Text('21% BTW')),
                  ],
                  onChanged: (v) => setState(() {
                    _vatRate = v ?? 0;
                    _recomputeVatFromGross();
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _vat,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: l10n.expenseVatAmount),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            // Home-use apportionment (家事按分)
            Row(children: [
              Text('${l10n.expenseDeductible} · 家事按分',
                  style: Theme.of(context).textTheme.labelLarge),
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
              onChanged: _deductible
                  ? (v) => setState(() => _businessUse = v.round())
                  : null,
            ),
            SwitchListTile(
              value: _deductible,
              onChanged: (v) => setState(() => _deductible = v),
              title: Text(l10n.expenseDeductible),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Text(l10n.expenseDeductible,
                    style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Text(fmt.money(deductible),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary)),
              ]),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }
}
