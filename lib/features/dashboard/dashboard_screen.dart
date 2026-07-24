import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/common.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../domain/tax/expense_categories.dart';
import '../../domain/tax/tax_provision.dart';
import '../../l10n/app_localizations.dart';
import '../shell/app_shell.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final profile = ref.watch(businessProfileProvider).value;
    final currency = Currency.fromCode(profile?.defaultCurrency ?? 'EUR');
    final rate = profile?.defaultHourlyRate ?? 0;

    final monthMinutes = ref.watch(monthMinutesProvider).value ?? 0;
    final unbilledMinutes = ref.watch(unbilledMinutesProvider).value ?? 0;
    final outstanding = ref.watch(outstandingInvoicesProvider).value ?? [];
    final allInvoices = ref.watch(invoicesProvider).value ?? [];

    final unbilledValue = Money.fromMajor((unbilledMinutes / 60) * rate, currency);

    final outstandingTotal = Money(
      outstanding
          .where((i) => i.currency == currency.code)
          .fold(0, (sum, i) => sum + i.totalMinor),
      currency,
    );

    final now = DateTime.now();
    final quarter = Quarter.ofMonth(now.month);
    final qStart = quarter.start(now.year);
    final qEnd = quarter.endExclusive(now.year);
    final quarterNet = Money(
      allInvoices
          .where((i) =>
              i.currency == currency.code &&
              !i.issueDate.isBefore(qStart) &&
              i.issueDate.isBefore(qEnd))
          .fold(0, (sum, i) => sum + i.subtotalMinor),
      currency,
    );

    final greeting =
        (profile?.tradeName.isNotEmpty ?? false) ? profile!.tradeName : l10n.dashboardWelcome;

    return Scaffold(
      appBar: AppBar(
        leading: navLeading(context),
        title: Text(l10n.navDashboard),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(greeting, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(fmt.monthYear(now),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            _KpiGrid(children: [
              KpiCard(
                label: l10n.dashboardHoursThisMonth,
                value: fmt.hoursFromMinutes(monthMinutes),
                icon: Icons.schedule,
                onTap: () => context.go('/time'),
              ),
              KpiCard(
                label: l10n.dashboardUnbilled,
                value: fmt.hoursFromMinutes(unbilledMinutes),
                sublabel: rate > 0 ? '≈ ${fmt.money(unbilledValue)}' : null,
                icon: Icons.hourglass_bottom,
                accent: Theme.of(context).colorScheme.tertiary,
                onTap: () => context.go('/invoices'),
              ),
              KpiCard(
                label: l10n.dashboardOutstanding,
                value: '${outstanding.length}',
                sublabel: outstandingTotal.isZero ? null : fmt.money(outstandingTotal),
                icon: Icons.receipt_long,
                onTap: () => context.go('/invoices'),
              ),
              KpiCard(
                label: '${l10n.reportPeriod} · Q${quarter.number}',
                value: fmt.money(quarterNet),
                sublabel: l10n.commonNet,
                icon: Icons.insights,
                onTap: () => context.go('/reports'),
              ),
            ]),
            const SizedBox(height: 24),
            SectionHeader(title: 'Tax set-aside'),
            const _TaxSetAsideCard(),
            const SizedBox(height: 24),
            SectionHeader(title: l10n.dashboardWelcome),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.add_task),
                    title: Text(l10n.dashboardQuickTime),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/time'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.note_add_outlined),
                    title: Text(l10n.dashboardQuickInvoice),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/invoices'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A year-to-date "reserve for the Japan tax bill" estimate, so the fixed
/// billed rate's real after-tax value is visible. Everything here is an
/// estimate — it converts profit to yen at the Settings FX rate and runs the
/// JP income-tax estimator (see [TaxProvision]).
class _TaxSetAsideCard extends ConsumerWidget {
  const _TaxSetAsideCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(businessProfileProvider).value;
    final invoices = ref.watch(invoicesProvider).value ?? const [];
    final expenses = ref.watch(expensesProvider).value ?? const [];
    final fmt = ref.watch(formattersProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final year = DateTime.now().year;
    final fx = profile?.eurToJpyRate ?? 160;

    // YTD net revenue per currency (exclude cancelled invoices).
    final revenue = <Currency, int>{};
    for (final i in invoices) {
      if (i.issueDate.year != year) continue;
      if (i.status == InvoiceStatus.cancelled.name) continue;
      final c = Currency.fromCode(i.currency);
      revenue.update(c, (v) => v + i.subtotalMinor,
          ifAbsent: () => i.subtotalMinor);
    }
    // YTD deductible expenses per currency (after 家事按分).
    final spend = <Currency, int>{};
    for (final e in expenses) {
      if (e.date.year != year) continue;
      final ded = deductibleMinorOf(
        deductible: e.deductible,
        amountMinor: e.amountMinor,
        businessUsePercent: e.businessUsePercent,
      );
      if (ded == 0) continue;
      final c = Currency.fromCode(e.currency);
      spend.update(c, (v) => v + ded, ifAbsent: () => ded);
    }

    // Convert (revenue − expenses) to whole yen for the estimate.
    double profitYen = 0;
    for (final c in {...revenue.keys, ...spend.keys}) {
      final profitMajor =
          Money((revenue[c] ?? 0) - (spend[c] ?? 0), c).asMajor;
      profitYen += c == Currency.jpy ? profitMajor : profitMajor * fx;
    }
    final provision = TaxProvision.fromProfitJpy(profitYen.round());
    String yen(int v) => fmt.money(Money(v, Currency.jpy));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.savings_outlined, size: 18, color: scheme.primary),
              const SizedBox(width: 8),
              Text('Reserve for Japanese tax', style: text.titleSmall),
              const Spacer(),
              Text('$year · est.',
                  style: text.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant)),
            ]),
            const SizedBox(height: 12),
            if (provision.profitJpy <= 0)
              Text(
                'No net profit recorded yet this year. Once you invoice and log '
                'expenses, your estimated tax reserve appears here.',
                style: text.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              )
            else ...[
              _row(context, 'YTD profit', yen(provision.profitJpy)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Expanded(
                    child: Text('Set aside now',
                        style: text.bodyMedium?.copyWith(
                            color: scheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600)),
                  ),
                  Text(yen(provision.setAsideJpy),
                      style: text.titleMedium?.copyWith(
                          color: scheme.onPrimaryContainer,
                          fontWeight: FontWeight.w800)),
                ]),
              ),
              const SizedBox(height: 8),
              _row(context, 'Effective rate on profit',
                  '${(provision.effectiveRate * 100).toStringAsFixed(1)}%'),
              _row(context, 'Take-home after reserve',
                  yen(provision.takeHomeJpy)),
              if ((profile?.defaultHourlyRate ?? 0) > 0) ...[
                const Divider(height: 20),
                Text(
                  'At your ${_rate(profile!.defaultHourlyRate, profile.defaultCurrency)} '
                  'billed rate, ≈ ${_rate(provision.takeHomePerHour(profile.defaultHourlyRate), profile.defaultCurrency)} '
                  'is take-home per hour after this reserve.',
                  style: text.bodySmall,
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Estimate at €1 = ¥${fx.toStringAsFixed(0)} (edit in Settings). '
                'Ignores personal deductions, so it reserves a little extra. '
                'Confirm with your 税理士.',
                style: text.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _rate(double major, String currencyCode) {
    final c = Currency.fromCode(currencyCode);
    final v = c.decimals == 0 ? major.round().toString() : major.toStringAsFixed(0);
    return '${c.symbol}$v';
  }

  Widget _row(BuildContext context, String label, String value) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        Expanded(
          child: Text(label,
              style: text.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
        Text(value, style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

/// Lays KPI cards into responsive columns (1–4 across).
class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = switch (constraints.maxWidth) {
          >= 1000 => 4,
          >= 680 => 3,
          >= 420 => 2,
          _ => 1,
        };
        const gap = 14.0;
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}
