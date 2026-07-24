import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/common.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';

class TimeScreen extends ConsumerWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final entries = ref.watch(monthTimeEntriesProvider).value ?? const [];
    final clients = ref.watch(clientsProvider).value ?? const [];
    final clientNames = {for (final c in clients) c.id: c.name};
    final totalMinutes = entries.fold<int>(0, (s, e) => s + e.minutes);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navTime),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Text(
                '${fmt.monthYear(DateTime.now())} · ${fmt.hoursFromMinutes(totalMinutes)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: clients.isEmpty
            ? null
            : () => _openEntry(context, ref, clients),
        icon: const Icon(Icons.add),
        label: Text(l10n.dashboardQuickTime),
      ),
      body: SafeArea(
        child: entries.isEmpty
            ? EmptyState(
                icon: Icons.schedule_outlined,
                message: clients.isEmpty
                    ? 'Add a client first, then log time.'
                    : l10n.commonEmpty,
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                itemCount: entries.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final e = entries[i];
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
                        ref.read(repositoryProvider).deleteTimeEntry(e.id),
                    child: ListTile(
                      title: Text(e.description.isEmpty
                          ? (clientNames[e.clientId] ?? '—')
                          : e.description),
                      subtitle: Text(
                          '${clientNames[e.clientId] ?? '—'} · ${fmt.date(e.date)}'),
                      trailing: Text(
                        fmt.hoursFromMinutes(e.minutes),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontFeatures: const [
                              FontFeature.tabularFigures()
                            ]),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _openEntry(BuildContext context, WidgetRef ref, List<Client> clients) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _TimeEntrySheet(clients: clients),
    );
  }
}

class _TimeEntrySheet extends ConsumerStatefulWidget {
  const _TimeEntrySheet({required this.clients});
  final List<Client> clients;
  @override
  ConsumerState<_TimeEntrySheet> createState() => _TimeEntrySheetState();
}

class _TimeEntrySheetState extends ConsumerState<_TimeEntrySheet> {
  late String _clientId = widget.clients.first.id;
  String? _projectId;
  DateTime _date = DateTime.now();
  final _hours = TextEditingController();
  final _desc = TextEditingController();
  bool _billable = true;

  @override
  void dispose() {
    _hours.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final hours = double.tryParse(_hours.text.replaceAll(',', '.').trim()) ?? 0;
    final minutes = (hours * 60).round();
    if (minutes <= 0) return;
    final repo = ref.read(repositoryProvider);
    await repo.upsertTimeEntry(TimeEntriesCompanion(
      id: Value(repo.newId()),
      clientId: Value(_clientId),
      projectId: Value(_projectId),
      date: Value(DateTime(_date.year, _date.month, _date.day)),
      minutes: Value(minutes),
      description: Value(_desc.text.trim()),
      billable: Value(_billable),
    ));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.dashboardQuickTime,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _clientId,
            decoration: InputDecoration(labelText: l10n.navClients),
            items: [
              for (final c in widget.clients)
                DropdownMenuItem(value: c.id, child: Text(c.name)),
            ],
            onChanged: (v) => setState(() {
              _clientId = v ?? _clientId;
              _projectId = null;
            }),
          ),
          Builder(builder: (context) {
            final projects =
                ref.watch(projectsProvider(_clientId)).value ?? const [];
            final active = projects.where((p) => p.active).toList();
            if (active.isEmpty) return const SizedBox(height: 12);
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: DropdownButtonFormField<String?>(
                initialValue: _projectId,
                decoration: InputDecoration(labelText: l10n.projectsTitle),
                items: [
                  DropdownMenuItem(value: null, child: Text('— ${l10n.projectsTitle} —')),
                  for (final p in active)
                    DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _projectId = v),
              ),
            );
          }),
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
              child: TextField(
                controller: _hours,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    labelText: l10n.commonHours, hintText: 'e.g. 3.5'),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            decoration: InputDecoration(labelText: l10n.invoiceDescription),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: _billable,
            onChanged: (v) => setState(() => _billable = v),
            title: const Text('Billable'),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
