import 'package:collection/collection.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/formatters.dart';
import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/labels.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../domain/tax/contractor_allowance.dart';
import '../../domain/tax/invoice_totals.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';

/// Fallback payment terms for a draft that has no client selected yet; real
/// terms come from the client record once one is picked.
const int _defaultTermDays = 30;

/// A single editable invoice line, owning its own text controllers.
class _EditLine {
  _EditLine({
    required this.description,
    required double quantity,
    required double unitPrice,
    required this.treatment,
    this.fromTimeEntries = false,
  })  : descCtrl = TextEditingController(text: description),
        qtyCtrl = TextEditingController(text: _trim(quantity)),
        priceCtrl = TextEditingController(text: _trim(unitPrice));

  final TextEditingController descCtrl;
  final TextEditingController qtyCtrl;
  final TextEditingController priceCtrl;
  String description;
  VatTreatment treatment;
  String unit = 'hours';
  /// Whether this line was generated from pulled time entries (vs. typed in
  /// by hand) — lets "refresh" regenerate time-tracked lines while leaving
  /// manual ones alone.
  bool fromTimeEntries;

  double get quantity =>
      double.tryParse(qtyCtrl.text.replaceAll(',', '.').trim()) ?? 0;
  double get unitPrice =>
      double.tryParse(priceCtrl.text.replaceAll(',', '.').trim()) ?? 0;

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  void dispose() {
    descCtrl.dispose();
    qtyCtrl.dispose();
    priceCtrl.dispose();
  }
}

class InvoiceEditorScreen extends ConsumerStatefulWidget {
  const InvoiceEditorScreen({super.key, this.invoiceId});
  final String? invoiceId;
  @override
  ConsumerState<InvoiceEditorScreen> createState() =>
      _InvoiceEditorScreenState();
}

class _InvoiceEditorScreenState extends ConsumerState<InvoiceEditorScreen> {
  String? _clientId;
  Currency _currency = Currency.eur;
  String _language = 'nl';
  DateTime _issueDate = DateTime.now();
  DateTime _dueDate = DateTime.now().add(const Duration(days: _defaultTermDays));
  /// Whether this invoice carries a due date at all. Off leaves the deadline
  /// off the document entirely; the picked date is still kept so switching
  /// back on restores it.
  bool _dueDateEnabled = true;
  /// Set once the due date has been picked by hand, after which it is left
  /// alone: changing the issue date or the client no longer recomputes it.
  bool _dueDateManual = false;
  /// Payment terms of the selected client, kept so the due date can be
  /// recomputed whenever the issue date moves.
  int _termDays = _defaultTermDays;
  int? _dueDayOfMonth;
  /// The contractor tax allowance for this invoice. New invoices start from
  /// the business profile's defaults; a saved invoice keeps what it was saved
  /// with, so reopening an old one never silently reprices it.
  ContractorAllowance _allowance = ContractorAllowance.none;
  late final _allowanceRateCtrl = TextEditingController();
  final _poCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final List<_EditLine> _lines = [];
  final Set<String> _pulledEntryIds = {};
  bool _saving = false;
  bool _loading = false;
  bool _refreshing = false;

  bool get _editing => widget.invoiceId != null;

  /// Due date for [issue] under the current client's terms: a fixed day of the
  /// month after issuance when the client uses one, otherwise net-[_termDays].
  /// Day-of-month terms track the issue month, so redating a draft from e.g.
  /// 3 September to 1 October moves the due date from 10 October to 10 November.
  DateTime _dueDateFor(DateTime issue) {
    final day = _dueDayOfMonth;
    if (day == null) return issue.add(Duration(days: _termDays));
    return DateTime(issue.year, issue.month + 1, day);
  }

  void _adoptTerms(Client client) {
    _termDays = client.paymentTermDays;
    _dueDayOfMonth = client.paymentDueDayOfMonth;
  }

  @override
  void initState() {
    super.initState();
    if (_editing) {
      _loading = true;
      _loadExisting(widget.invoiceId!);
    } else {
      // A fresh invoice adopts the profile's allowance defaults — this is the
      // standard way tax is added here, so it is on unless turned off.
      final profile = ref.read(businessProfileProvider).value;
      _allowance = ContractorAllowance(
        enabled: profile?.defaultAllowanceEnabled ?? true,
        ratePercent: profile?.defaultAllowanceRatePercent ?? 25,
        mode: AllowanceMode.byName(profile?.defaultAllowanceMode ?? 'surcharge'),
      );
      _allowanceRateCtrl.text = _trimRate(_allowance.ratePercent);
    }
  }

  static String _trimRate(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  Future<void> _loadExisting(String id) async {
    final repo = ref.read(repositoryProvider);
    final invoice = await repo.findInvoice(id);
    if (invoice == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final lines = await repo.invoiceLines(id);
    final linkedEntries = await repo.timeEntriesForInvoice(id);
    final client = await repo.findClient(invoice.clientId);
    if (!mounted) return;
    setState(() {
      _clientId = invoice.clientId;
      _currency = Currency.fromCode(invoice.currency);
      _language = invoice.language;
      _issueDate = invoice.issueDate;
      _dueDate = invoice.dueDate;
      _dueDateEnabled = invoice.dueDateEnabled;
      _allowance = ContractorAllowance(
        enabled: invoice.allowanceEnabled,
        ratePercent: invoice.allowanceRatePercent,
        mode: AllowanceMode.byName(invoice.allowanceMode),
      );
      _allowanceRateCtrl.text = _trimRate(invoice.allowanceRatePercent);
      if (client != null) _adoptTerms(client);
      // A saved invoice keeps the date it was saved with; re-picking a client
      // or redating it must not silently move an agreed deadline.
      _dueDateManual = true;
      _poCtrl.text = invoice.purchaseOrder;
      _notesCtrl.text = invoice.notes;
      for (final line in lines) {
        _lines.add(_EditLine(
          description: line.description,
          quantity: line.quantity,
          unitPrice: Money(line.unitPriceMinor, _currency).asMajor,
          treatment: VatTreatment.byName(line.vatTreatment),
          fromTimeEntries: line.fromTimeEntries,
        )..unit = line.unit);
      }
      _pulledEntryIds.addAll(linkedEntries.map((e) => e.id));
      _loading = false;
    });
  }

  @override
  void dispose() {
    _poCtrl.dispose();
    _notesCtrl.dispose();
    _allowanceRateCtrl.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  Future<void> _applyClient(Client client) async {
    final repo = ref.read(repositoryProvider);
    final profile = ref.read(businessProfileProvider).value;
    setState(() {
      _clientId = client.id;
      _currency = Currency.fromCode(client.defaultCurrency);
      _language = client.language;
      _adoptTerms(client);
      if (!_dueDateManual) _dueDate = _dueDateFor(_issueDate);
    });
    // Auto-pull unbilled time, grouped into lines per project.
    final entries = await repo.unbilledEntriesForClient(client.id);
    final projects = await repo.projectsForClient(client.id);
    if (entries.isNotEmpty && mounted) {
      _pullEntries(entries, client, profile, {for (final p in projects) p.id: p});
    }
  }

  void _pullEntries(List<TimeEntry> entries, Client client,
      BusinessProfile? profile, Map<String, Project> projects) {
    final clientRate = client.defaultHourlyRate ?? profile?.defaultHourlyRate ?? 0;
    final treatment = VatTreatment.byName(client.defaultVatTreatment);
    // Group by project (null project => one combined line).
    final byProject = groupBy(entries, (TimeEntry e) => e.projectId);
    setState(() {
      byProject.forEach((projectId, group) {
        final minutes = group.fold<int>(0, (s, e) => s + e.minutes);
        final project = projectId == null ? null : projects[projectId];
        _lines.add(_EditLine(
          description: project?.name ?? 'Professional services',
          quantity: minutes / 60.0,
          unitPrice: project?.hourlyRate ?? clientRate,
          treatment: treatment,
          fromTimeEntries: true,
        ));
        _pulledEntryIds.addAll(group.map((e) => e.id));
      });
    });
  }

  /// Re-pulls time entries for the current client — picking up hours logged
  /// since this invoice was created/last refreshed — and regenerates the
  /// time-tracked lines from scratch. Lines added by hand are left as-is.
  Future<void> _refresh() async {
    final clientId = _clientId;
    if (clientId == null || _refreshing) return;
    setState(() => _refreshing = true);
    final repo = ref.read(repositoryProvider);
    final client = (ref.read(clientsProvider).value ?? const <Client>[])
        .firstWhereOrNull((c) => c.id == clientId);
    if (client == null) {
      setState(() => _refreshing = false);
      return;
    }
    final profile = ref.read(businessProfileProvider).value;
    final entries = await repo.entriesAvailableForInvoice(clientId,
        invoiceId: widget.invoiceId);
    final projects = await repo.projectsForClient(clientId);
    if (!mounted) return;

    setState(() {
      final stale = _lines.where((l) => l.fromTimeEntries).toList();
      for (final l in stale) {
        l.dispose();
      }
      _lines.removeWhere((l) => l.fromTimeEntries);
      _pulledEntryIds.clear();
    });
    if (entries.isNotEmpty) {
      _pullEntries(
          entries, client, profile, {for (final p in projects) p.id: p});
    }
    if (mounted) setState(() => _refreshing = false);
  }

  void _addBlankLine() {
    final treatment = _clientId == null
        ? VatTreatment.reverseChargeEu
        : VatTreatment.byName(
            (ref.read(clientsProvider).value ?? [])
                    .firstWhereOrNull((c) => c.id == _clientId)
                    ?.defaultVatTreatment ??
                'reverseChargeEu');
    setState(() {
      _lines.add(_EditLine(
        description: '',
        quantity: 1,
        unitPrice: 0,
        treatment: treatment,
      ));
    });
  }

  InvoiceTotals _computeTotals() {
    final taxable = _lines
        .map((l) => TaxableLine(
              net: Money.fromMajor(l.unitPrice, _currency).times(l.quantity),
              treatment: l.treatment,
            ))
        .toList();
    return InvoiceCalculator.compute(taxable, _currency,
        allowance: _allowance);
  }

  Future<void> _save() async {
    if (_clientId == null || _lines.isEmpty || _saving) return;
    setState(() => _saving = true);
    final repo = ref.read(repositoryProvider);
    final totals = _computeTotals();
    final id = widget.invoiceId ?? repo.newId();

    final lineCompanions = <InvoiceLinesCompanion>[];
    for (var i = 0; i < _lines.length; i++) {
      final l = _lines[i];
      lineCompanions.add(InvoiceLinesCompanion.insert(
        id: repo.newId(),
        invoiceId: id,
        description: l.descCtrl.text.trim().isEmpty
            ? 'Professional services'
            : l.descCtrl.text.trim(),
        unitPriceMinor: Money.fromMajor(l.unitPrice, _currency).minorUnits,
        quantity: Value(l.quantity),
        unit: Value(l.unit),
        vatTreatment: Value(l.treatment.name),
        sortOrder: Value(i),
        fromTimeEntries: Value(l.fromTimeEntries),
      ));
    }

    if (_editing) {
      await repo.updateInvoiceWithLines(
        id: id,
        invoice: InvoicesCompanion(
          clientId: Value(_clientId!),
          issueDate: Value(_issueDate),
          dueDate: Value(_dueDate),
          dueDateEnabled: Value(_dueDateEnabled),
          currency: Value(_currency.code),
          language: Value(_language),
          purchaseOrder: Value(_poCtrl.text.trim()),
          notes: Value(_notesCtrl.text.trim()),
          subtotalMinor: Value(totals.net.minorUnits),
          taxMinor: Value(totals.taxTotal.minorUnits),
          allowanceEnabled: Value(_allowance.enabled),
          allowanceRatePercent: Value(_allowance.ratePercent),
          allowanceMode: Value(_allowance.mode.name),
          allowanceMinor: Value(totals.allowanceAmount.minorUnits),
          totalMinor: Value(totals.gross.minorUnits),
        ),
        lines: lineCompanions,
        timeEntryIds: _pulledEntryIds.toList(),
      );
    } else {
      final number = await repo.nextInvoiceNumber();
      await repo.createInvoice(
        invoice: InvoicesCompanion.insert(
          id: id,
          number: number,
          clientId: _clientId!,
          issueDate: _issueDate,
          dueDate: _dueDate,
          dueDateEnabled: Value(_dueDateEnabled),
          createdAt: DateTime.now(),
          currency: Value(_currency.code),
          language: Value(_language),
          status: Value(InvoiceStatus.draft.name),
          purchaseOrder: Value(_poCtrl.text.trim()),
          notes: Value(_notesCtrl.text.trim()),
          subtotalMinor: Value(totals.net.minorUnits),
          taxMinor: Value(totals.taxTotal.minorUnits),
          allowanceEnabled: Value(_allowance.enabled),
          allowanceRatePercent: Value(_allowance.ratePercent),
          allowanceMode: Value(_allowance.mode.name),
          allowanceMinor: Value(totals.allowanceAmount.minorUnits),
          totalMinor: Value(totals.gross.minorUnits),
        ),
        lines: lineCompanions,
        timeEntryIds: _pulledEntryIds.toList(),
      );
    }

    if (mounted) context.go('/invoices/$id');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final closeTarget =
        _editing ? '/invoices/${widget.invoiceId}' : '/invoices';

    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.go(closeTarget),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final fmt = ref.watch(formattersProvider);
    final clients = ref.watch(clientsProvider).value ?? const [];
    final totals = _computeTotals();

    return Scaffold(
      appBar: AppBar(
        title: Text(_editing ? l10n.commonEdit : l10n.dashboardQuickInvoice),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go(closeTarget),
        ),
        actions: [
          IconButton(
            icon: _refreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            tooltip: l10n.commonRefresh,
            onPressed: _clientId == null || _refreshing ? null : _refresh,
          ),
        ],
      ),
      bottomNavigationBar: _SaveBar(
        total: fmt.money(totals.gross),
        enabled: _clientId != null && _lines.isNotEmpty && !_saving,
        onSave: _save,
        label: l10n.commonSave,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Client + meta
            DropdownButtonFormField<String>(
              initialValue: _clientId,
              decoration: InputDecoration(labelText: l10n.invoiceBillTo),
              items: [
                for (final c in clients)
                  DropdownMenuItem(value: c.id, child: Text(c.name)),
              ],
              onChanged: (v) {
                final c = clients.firstWhereOrNull((c) => c.id == v);
                if (c != null) _applyClient(c);
              },
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: _DateField(
                  label: l10n.invoiceIssueDate,
                  value: _issueDate,
                  format: fmt.date,
                  onPick: (d) => setState(() {
                    _issueDate = d;
                    if (!_dueDateManual) _dueDate = _dueDateFor(d);
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DateField(
                  label: l10n.invoiceDueDate,
                  value: _dueDate,
                  format: fmt.date,
                  enabled: _dueDateEnabled,
                  onPick: (d) => setState(() {
                    _dueDate = d;
                    _dueDateManual = true;
                  }),
                ),
              ),
            ]),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(l10n.invoiceDueDateEnabled),
              value: _dueDateEnabled,
              onChanged: (v) => setState(() => _dueDateEnabled = v),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(l10n.invoiceDescription,
                    style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                TextButton.icon(
                  onPressed: _addBlankLine,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.commonAdd),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_lines.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    _clientId == null
                        ? 'Select a client — any unbilled time will be pulled in automatically.'
                        : 'No lines yet. Add one manually.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            for (final line in _lines) _lineCard(line, l10n),
            const SizedBox(height: 16),
            _AllowanceCard(
              allowance: _allowance,
              rateCtrl: _allowanceRateCtrl,
              l10n: l10n,
              onChanged: (a) => setState(() => _allowance = a),
            ),
            const SizedBox(height: 12),
            _TotalsCard(totals: totals, fmt: fmt, l10n: l10n),
            const SizedBox(height: 12),
            TextField(
              controller: _notesCtrl,
              decoration: InputDecoration(labelText: l10n.invoiceThankYou),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _lineCard(_EditLine line, L10n l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: line.descCtrl,
                    decoration:
                        InputDecoration(labelText: l10n.invoiceDescription),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(() {
                    line.dispose();
                    _lines.remove(line);
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: line.qtyCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: l10n.invoiceQuantity),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: line.priceCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.invoiceUnitPrice,
                    prefixText: '${_currency.symbol} ',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            DropdownButtonFormField<VatTreatment>(
              initialValue: line.treatment,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'VAT', isDense: true),
              items: [
                for (final t in VatTreatment.values)
                  DropdownMenuItem(
                    value: t,
                    child: Text(vatTreatmentLabel(l10n, t),
                        overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (v) => setState(
                  () => line.treatment = v ?? VatTreatment.reverseChargeEu),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.format,
    required this.onPick,
    this.enabled = true,
  });
  final String label;
  final DateTime value;
  final String Function(DateTime) format;
  final ValueChanged<DateTime> onPick;
  /// A disabled field greys out and stops opening the calendar — used for the
  /// due date while the invoice carries none.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !enabled
          ? null
          : () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: value,
                // Wide enough to pick any plausible day/month/year by hand,
                // including a backdated invoice.
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) onPick(picked);
            },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, enabled: enabled),
        child: Text(
          format(value),
          style: enabled
              ? null
              : TextStyle(color: Theme.of(context).disabledColor),
        ),
      ),
    );
  }
}

/// Editor for the contractor tax allowance: whether it applies, at what rate,
/// and how it's derived. The two modes differ in a way that is easy to get
/// wrong, so the card states the consequence of the chosen one inline.
class _AllowanceCard extends StatelessWidget {
  const _AllowanceCard({
    required this.allowance,
    required this.rateCtrl,
    required this.l10n,
    required this.onChanged,
  });

  final ContractorAllowance allowance;
  final TextEditingController rateCtrl;
  final L10n l10n;
  final ValueChanged<ContractorAllowance> onChanged;

  /// The rate as it should read on the invoice: "25", not "25.0".
  static String rateLabel(ContractorAllowance a) {
    final r = a.effectiveRatePercent;
    return r == r.roundToDouble() ? r.toStringAsFixed(0) : r.toString();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(l10n.invoiceAllowanceEnabled),
              value: allowance.enabled,
              onChanged: (v) => onChanged(allowance.copyWith(enabled: v)),
            ),
            if (allowance.enabled) ...[
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  width: 110,
                  child: TextField(
                    controller: rateCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration:
                        InputDecoration(labelText: l10n.invoiceAllowanceRate),
                    onChanged: (v) => onChanged(allowance.copyWith(
                      ratePercent:
                          double.tryParse(v.replaceAll(',', '.').trim()) ?? 0,
                    )),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<AllowanceMode>(
                    initialValue: allowance.mode,
                    isExpanded: true,
                    decoration:
                        InputDecoration(labelText: l10n.invoiceAllowanceMode),
                    items: [
                      DropdownMenuItem(
                        value: AllowanceMode.surcharge,
                        child: Text(l10n.allowanceModeSurcharge,
                            overflow: TextOverflow.ellipsis),
                      ),
                      DropdownMenuItem(
                        value: AllowanceMode.grossUp,
                        child: Text(l10n.allowanceModeGrossUp,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                    onChanged: (v) => onChanged(allowance.copyWith(
                        mode: v ?? AllowanceMode.surcharge)),
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              Text(
                switch (allowance.mode) {
                  AllowanceMode.surcharge => l10n.allowanceModeSurchargeHint,
                  AllowanceMode.grossUp => l10n.allowanceModeGrossUpHint,
                },
                style: text.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard(
      {required this.totals, required this.fmt, required this.l10n});
  final InvoiceTotals totals;
  final Formatters fmt;
  final L10n l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row(context, l10n.commonNet, fmt.money(totals.net)),
            for (final g in totals.taxGroups)
              if (!g.tax.isZero)
                _row(context, vatTreatmentLabel(l10n, g.treatment),
                    fmt.money(g.tax)),
            if (totals.hasAllowance)
              _row(
                  context,
                  l10n.invoiceAllowance(
                      _AllowanceCard.rateLabel(totals.allowance)),
                  fmt.money(totals.allowanceAmount)),
            const Divider(),
            _row(context, l10n.commonTotal, fmt.money(totals.gross), bold: true),
            if (totals.printsReverseChargeStatement) ...[
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  vatTreatmentNote(l10n, VatTreatment.reverseChargeEu),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value,
      {bool bold = false}) {
    final style = bold
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700)
        : Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({
    required this.total,
    required this.enabled,
    required this.onSave,
    required this.label,
  });
  final String total;
  final bool enabled;
  final VoidCallback onSave;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Text(total, style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            FilledButton.icon(
              onPressed: enabled ? onSave : null,
              icon: const Icon(Icons.check),
              label: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
