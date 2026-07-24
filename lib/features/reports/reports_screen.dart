import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../domain/tax/expense_categories.dart';
import '../../domain/tax/period_report.dart';
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

  Future<void> _timesheet({required bool markdown}) => _run(() async {
        final repo = ref.read(repositoryProvider);
        final profile = await repo.ensureBusinessProfile();
        final clients = await repo.allClientsOnce();
        final from = _quarter.start(_year);
        final to = _quarter.endExclusive(_year);
        final entries = await repo.timeEntriesBetween(from, to);
        final toIncl = to.subtract(const Duration(days: 1));
        if (markdown) {
          await ReportPdf.saveTimesheetMarkdown(
            profile: profile,
            clients: clients,
            entries: entries,
            from: from,
            toInclusive: toIncl,
            lang: _lang,
          );
        } else {
          await ReportPdf.shareTimesheet(
            profile: profile,
            clients: clients,
            entries: entries,
            from: from,
            toInclusive: toIncl,
            lang: _lang,
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
          revenue.update(currency, (v) => v + row.invoice.subtotalMinor,
              ifAbsent: () => row.invoice.subtotalMinor);
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
        await ReportPdf.shareAnnualIncome(
          profile: profile,
          report: IncomeReport(revenue: revenue, expenses: expenses),
          year: _year,
          lang: _lang,
          eurToJpy: double.tryParse(_fxCtrl.text.replaceAll(',', '.')) ?? 160,
        );
      });

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
                                  label: Text(lang.nativeName)),
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
                  subtitle: '$_year · Q${_quarter.number}',
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
