import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/document_name.dart';
import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../domain/tax/depreciation.dart';
import '../../domain/tax/expense_categories.dart';
import '../../domain/tax/period_report.dart';
import '../../domain/tax/report_period.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';
import '../shell/app_shell.dart';
import 'report_pdf.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});
  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late int _year = DateTime.now().year;
  late Quarter _quarter = Quarter.ofMonth(DateTime.now().month);
  late int _month = DateTime.now().month;
  /// Granularity of the timesheet only. The VAT report is filed per quarter,
  /// so it is deliberately not switchable.
  ReportPeriodKind _timesheetKind = ReportPeriodKind.quarter;
  late String _lang;
  final _fxCtrl = TextEditingController(text: '160');
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _lang = ref.read(appLanguageProvider).code;
    final storedFx = ref.read(businessProfileProvider).value?.eurToJpyRate;
    if (storedFx != null) _fxCtrl.text = storedFx.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _fxCtrl.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// The span the timesheet covers, per the selected granularity.
  ReportPeriod get _timesheetPeriod => switch (_timesheetKind) {
        ReportPeriodKind.quarter => ReportPeriod.ofQuarter(_year, _quarter),
        ReportPeriodKind.month => ReportPeriod.ofMonth(_year, _month),
      };

  /// The issuing business as it should appear in a filename.
  static String _issuerOf(BusinessProfile p) =>
      p.tradeName.isNotEmpty ? p.tradeName : p.legalName;

  Future<void> _timesheet({required bool markdown}) => _run(() async {
        final repo = ref.read(repositoryProvider);
        final profile = await repo.ensureBusinessProfile();
        final clients = await repo.allClientsOnce();
        final period = _timesheetPeriod;
        final filename = DocumentName.timesheet(
            issuer: _issuerOf(profile), period: period);
        final entries =
            await repo.timeEntriesBetween(period.start, period.endExclusive);
        if (markdown) {
          await ReportPdf.saveTimesheetMarkdown(
            profile: profile,
            clients: clients,
            entries: entries,
            from: period.start,
            toInclusive: period.endInclusive,
            lang: _lang,
            filename: filename,
          );
        } else {
          await ReportPdf.shareTimesheet(
            profile: profile,
            clients: clients,
            entries: entries,
            from: period.start,
            toInclusive: period.endInclusive,
            lang: _lang,
            filename: filename,
          );
        }
      });

  Future<void> _quarterlyVat() => _run(() async {
        final repo = ref.read(repositoryProvider);
        final profile = await repo.ensureBusinessProfile();
        final from = _quarter.start(_year);
        final to = _quarter.endExclusive(_year);
        final rows = await repo.invoicesWithLinesBetween(from, to);
        final lines = <ReportLine>[];
        for (final row in rows) {
          final currency = Currency.fromCode(row.invoice.currency);
          for (final l in row.lines) {
            lines.add(ReportLine(
              net: Money(l.unitPriceMinor, currency).times(l.quantity),
              treatment: VatTreatment.byName(l.vatTreatment),
            ));
          }
        }
        await ReportPdf.shareQuarterlyVat(
          profile: profile,
          report: VatReport.fromLines(lines),
          year: _year,
          quarter: _quarter.number,
          lang: _lang,
          filename: DocumentName.vatReturn(
              issuer: _issuerOf(profile), year: _year, quarter: _quarter),
        );
      });

  Future<void> _annualIncome() => _run(() async {
        final repo = ref.read(repositoryProvider);
        final profile = await repo.ensureBusinessProfile();
        final from = DateTime(_year, 1, 1);
        final to = DateTime(_year + 1, 1, 1);
        final rows = await repo.invoicesWithLinesBetween(from, to);
        final revenue = <Currency, int>{};
        for (final row in rows) {
          final currency = Currency.fromCode(row.invoice.currency);
          revenue.update(currency, (v) => v + row.invoice.revenueMinor,
              ifAbsent: () => row.invoice.revenueMinor);
        }
        final expenses = <Currency, int>{};
        for (final e in await repo.expensesBetween(from, to)) {
          final ded = deductibleMinorOf(
            deductible: e.deductible,
            amountMinor: e.amountMinor,
            businessUsePercent: e.businessUsePercent,
          );
          if (ded == 0) continue;
          final currency = Currency.fromCode(e.currency);
          expenses.update(currency, (v) => v + ded, ifAbsent: () => ded);
        }
        // Include this year's depreciation from the fixed-asset register.
        for (final a in await repo.allAssetsOnce()) {
          final dep = Depreciation.deductibleForYear(
            costMinor: a.costMinor,
            acquisition: a.acquisitionDate,
            method: DepreciationMethod.fromName(a.method),
            usefulLifeYears: a.usefulLifeYears,
            businessUsePercent: a.businessUsePercent,
            year: _year,
          );
          if (dep == 0) continue;
          final currency = Currency.fromCode(a.currency);
          expenses.update(currency, (v) => v + dep, ifAbsent: () => dep);
        }
        await ReportPdf.shareAnnualIncome(
          profile: profile,
          report: IncomeReport(revenue: revenue, expenses: expenses),
          year: _year,
          lang: _lang,
          eurToJpy: double.tryParse(_fxCtrl.text.replaceAll(',', '.')) ?? 160,
          filename:
              DocumentName.annualIncome(issuer: _issuerOf(profile), year: _year),
        );
      });

  String _timesheetSubtitle() {
    final period = _timesheetPeriod;
    return switch (_timesheetKind) {
      ReportPeriodKind.quarter => '$_year · Q${_quarter.number}',
      ReportPeriodKind.month =>
        ref.read(formattersProvider).monthYear(period.start),
    };
  }

  /// Quarter-or-month choice for the timesheet, with the month picker shown
  /// only when it applies. Lives inside the timesheet card because it governs
  /// that report alone — the VAT return's period is set by the tax authority.
  Widget _timesheetPeriodPicker(L10n l10n) {
    final fmt = ref.watch(formattersProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<ReportPeriodKind>(
          segments: [
            ButtonSegment(
                value: ReportPeriodKind.quarter,
                label: Text(l10n.reportPeriodQuarter)),
            ButtonSegment(
                value: ReportPeriodKind.month,
                label: Text(l10n.reportPeriodMonth)),
          ],
          selected: {_timesheetKind},
          onSelectionChanged: (s) =>
              setState(() => _timesheetKind = s.first),
        ),
        if (_timesheetKind == ReportPeriodKind.month) ...[
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: _month,
            isExpanded: true,
            decoration: InputDecoration(
                labelText: l10n.reportPeriodMonth, isDense: true),
            items: [
              for (var m = 1; m <= 12; m++)
                DropdownMenuItem(
                  value: m,
                  child: Text(fmt.monthYear(DateTime(_year, m))),
                ),
            ],
            onChanged: (v) => setState(() => _month = v ?? _month),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final years = [for (var y = DateTime.now().year; y >= 2022; y--) y];

    return Scaffold(
      appBar: AppBar(leading: navLeading(context), title: Text(l10n.navReports)),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Period + language controls
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _year,
                              decoration: const InputDecoration(labelText: 'Year'),
                              items: [
                                for (final y in years)
                                  DropdownMenuItem(value: y, child: Text('$y')),
                              ],
                              onChanged: (v) => setState(() => _year = v ?? _year),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<Quarter>(
                              initialValue: _quarter,
                              decoration:
                                  const InputDecoration(labelText: 'Quarter'),
                              items: [
                                for (final q in Quarter.values)
                                  DropdownMenuItem(
                                      value: q, child: Text('Q${q.number}')),
                              ],
                              onChanged: (v) =>
                                  setState(() => _quarter = v ?? _quarter),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 12),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(l10n.settingsLanguage,
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                        const SizedBox(height: 6),
                        SegmentedButton<String>(
                          segments: [
                            for (final lang in AppLanguage.values)
                              ButtonSegment(
                                  value: lang.code,
                                  label: Text(lang.code.toUpperCase())),
                          ],
                          selected: {_lang},
                          onSelectionChanged: (s) =>
                              setState(() => _lang = s.first),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _reportCard(
                  icon: Icons.schedule,
                  title: l10n.reportTimesheet,
                  subtitle: _timesheetSubtitle(),
                  leadingContent: _timesheetPeriodPicker(l10n),
                  actions: [
                    _btn(l10n.commonExportPdf, () => _timesheet(markdown: false)),
                    _btn(l10n.commonExportMarkdown,
                        () => _timesheet(markdown: true),
                        filled: false),
                  ],
                ),
                _reportCard(
                  icon: Icons.calendar_view_week,
                  title: l10n.reportQuarterlyVat,
                  subtitle: '$_year · Q${_quarter.number} · ${Portals.nlVat}',
                  actions: [_btn(l10n.commonExportPdf, _quarterlyVat)],
                ),
                _reportCard(
                  icon: Icons.summarize,
                  title: l10n.reportAnnualIncome,
                  subtitle: '$_year · 確定申告 · e-Tax',
                  actions: [
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _fxCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                            labelText: '€1 = ¥', isDense: true),
                      ),
                    ),
                    _btn(l10n.commonExportPdf, _annualIncome),
                  ],
                ),
                const SizedBox(height: 12),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: [
                      const Icon(Icons.info_outline, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(l10n.settingsTaxDisclaimer,
                              style: Theme.of(context).textTheme.bodySmall)),
                    ]),
                  ),
                ),
              ],
            ),
            if (_busy)
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0x66000000),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _reportCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Widget> actions,
    /// Optional controls specific to this report, shown between the heading
    /// and the export buttons.
    Widget? leadingContent,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ]),
            if (leadingContent != null) ...[
              const SizedBox(height: 14),
              leadingContent,
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(String label, VoidCallback onTap, {bool filled = true}) {
    // Bounded width + a Flexible, ellipsizing label so a long translation never
    // overflows the button (and the Wrap can flow buttons onto the next line).
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(filled ? Icons.picture_as_pdf : Icons.description_outlined,
            size: 18),
        const SizedBox(width: 8),
        Flexible(
          child: Text(label,
              maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
        ),
      ],
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 240),
      child: filled
          ? FilledButton(onPressed: onTap, child: child)
          : OutlinedButton(onPressed: onTap, child: child),
    );
  }
}
