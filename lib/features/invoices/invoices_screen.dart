import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/common.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../l10n/app_localizations.dart';

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final invoices = ref.watch(invoicesProvider).value ?? const [];
    final clients = ref.watch(clientsProvider).value ?? const [];
    final clientNames = {for (final c in clients) c.id: c.name};

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navInvoices)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: clients.isEmpty
            ? null
            : () => context.go('/invoices/new'),
        icon: const Icon(Icons.add),
        label: Text(l10n.dashboardQuickInvoice),
      ),
      body: SafeArea(
        child: invoices.isEmpty
            ? EmptyState(icon: Icons.receipt_long_outlined, message: l10n.commonEmpty)
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                itemCount: invoices.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final inv = invoices[i];
                  final currency = Currency.fromCode(inv.currency);
                  final status = InvoiceStatus.byName(inv.status);
                  return Card(
                    child: ListTile(
                      onTap: () => context.go('/invoices/${inv.id}'),
                      title: Text(inv.number),
                      subtitle: Text(
                          '${clientNames[inv.clientId] ?? '—'} · ${fmt.date(inv.issueDate)}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(fmt.money(Money(inv.totalMinor, currency)),
                              style: Theme.of(context).textTheme.titleMedium),
                          _StatusChip(status: status),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final (label, color) = switch (status) {
      InvoiceStatus.draft => (l10n.statusDraft, Colors.grey),
      InvoiceStatus.sent => (l10n.statusSent, Colors.blue),
      InvoiceStatus.paid => (l10n.statusPaid, Colors.green),
      InvoiceStatus.overdue => (l10n.statusOverdue, Colors.red),
      InvoiceStatus.cancelled => (l10n.statusCancelled, Colors.grey),
    };
    return Text(label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color));
  }
}
