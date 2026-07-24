import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/common.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
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
