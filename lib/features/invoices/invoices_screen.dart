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

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});

  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen> {
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
    await ref.read(repositoryProvider).deleteInvoices(_selected.toList());
    if (mounted) _exitSelection();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final invoices = ref.watch(invoicesProvider).value ?? const [];
    final clients = ref.watch(clientsProvider).value ?? const [];
    final clientNames = {for (final c in clients) c.id: c.name};

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
                  onPressed: () => setState(
                      () => _selected.addAll(invoices.map((i) => i.id))),
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
              title: Text(l10n.navInvoices),
              actions: [
                if (invoices.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.checklist),
                    tooltip: l10n.commonSelect,
                    onPressed: () => setState(() => _selecting = true),
                  ),
              ],
            ),
      floatingActionButton: _selecting
          ? null
          : FloatingActionButton.extended(
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
                  final selected = _selected.contains(inv.id);
                  final tile = Card(
                    child: ListTile(
                      leading: _selecting
                          ? Checkbox(
                              value: selected,
                              onChanged: (_) => _toggle(inv.id),
                            )
                          : null,
                      onTap: _selecting
                          ? () => _toggle(inv.id)
                          : () => context.go('/invoices/${inv.id}'),
                      onLongPress:
                          _selecting ? null : () => _enterSelection(inv.id),
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
                  if (_selecting) return tile;
                  return Dismissible(
                    key: ValueKey(inv.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete_outline),
                    ),
                    onDismissed: (_) =>
                        ref.read(repositoryProvider).deleteInvoice(inv.id),
                    child: tile,
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
