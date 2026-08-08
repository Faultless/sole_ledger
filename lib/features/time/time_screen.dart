import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/common.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../l10n/app_localizations.dart';
import '../shell/app_shell.dart';

class TimeScreen extends ConsumerStatefulWidget {
  const TimeScreen({super.key});

  @override
  ConsumerState<TimeScreen> createState() => _TimeScreenState();
}

DateTime _startOfMonth(DateTime d) => DateTime(d.year, d.month, 1);

class _TimeScreenState extends ConsumerState<TimeScreen> {
  bool _selecting = false;
  final Set<String> _selected = {};
  late DateTime _month = _startOfMonth(DateTime.now());

  void _shiftMonth(int delta) {
    setState(() {
      _month = DateTime(_month.year, _month.month + delta, 1);
      _selected.clear();
      _selecting = false;
    });
  }

  bool get _isCurrentMonth => _month == _startOfMonth(DateTime.now());

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
    await ref.read(repositoryProvider).deleteTimeEntries(_selected.toList());
    if (mounted) _exitSelection();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final entries = ref.watch(timeEntriesForMonthProvider(_month)).value ?? const [];
    final clients = ref.watch(clientsProvider).value ?? const [];
    final clientNames = {for (final c in clients) c.id: c.name};
    final totalMinutes = entries.fold<int>(0, (s, e) => s + e.minutes);

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
                      setState(() => _selected.addAll(entries.map((e) => e.id))),
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
              title: Text(l10n.navTime),
              actions: [
                if (entries.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.checklist),
                    tooltip: l10n.commonSelect,
                    onPressed: () => setState(() => _selecting = true),
                  ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 16, 6),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        visualDensity: VisualDensity.compact,
                        onPressed: () => _shiftMonth(-1),
                      ),
                      Text(
                        '${fmt.monthYear(_month)} · ${fmt.hoursFromMinutes(totalMinutes)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        visualDensity: VisualDensity.compact,
                        onPressed: _isCurrentMonth ? null : () => _shiftMonth(1),
                      ),
                      if (!_isCurrentMonth) ...[
                        const Spacer(),
                        TextButton(
                          onPressed: () => setState(
                              () => _month = _startOfMonth(DateTime.now())),
                          child: Text(l10n.commonToday),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: _selecting
          ? null
          : FloatingActionButton.extended(
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
                  final selected = _selected.contains(e.id);
                  final tile = ListTile(
                    leading: _selecting
                        ? Checkbox(
                            value: selected,
                            onChanged: (_) => _toggle(e.id),
                          )
                        : null,
                    title: Text(e.description.isEmpty
                        ? (clientNames[e.clientId] ?? '—')
                        : e.description),
                    subtitle: Text(
                        '${clientNames[e.clientId] ?? '—'} · ${fmt.date(e.date)}'),
                    trailing: Text(
                      fmt.hoursFromMinutes(e.minutes),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFeatures: const [FontFeature.tabularFigures()]),
                    ),
                    selected: selected,
                    onTap: _selecting
                        ? () => _toggle(e.id)
                        : () => _openEntry(context, ref, clients, entry: e),
                    onLongPress:
                        _selecting ? null : () => _enterSelection(e.id),
                  );
                  if (_selecting) return tile;
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
                    child: tile,
                  );
                },
              ),
      ),
    );
  }

  void _openEntry(BuildContext context, WidgetRef ref, List<Client> clients,
      {TimeEntry? entry}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _TimeEntrySheet(clients: clients, entry: entry),
    );
  }
}

class _TimeEntrySheet extends ConsumerStatefulWidget {
  const _TimeEntrySheet({required this.clients, this.entry});
  final List<Client> clients;
  final TimeEntry? entry;
  @override
  ConsumerState<_TimeEntrySheet> createState() => _TimeEntrySheetState();
}

class _TimeEntrySheetState extends ConsumerState<_TimeEntrySheet> {
  late String _clientId = widget.entry?.clientId ?? widget.clients.first.id;
  late String? _projectId = widget.entry?.projectId;
  late DateTime _date = widget.entry?.date ?? DateTime.now();
  late final _hours = TextEditingController(
      text: widget.entry == null ? '' : _trimHours(widget.entry!.minutes / 60.0));
  late final _desc =
      TextEditingController(text: widget.entry?.description ?? '');
  late bool _billable = widget.entry?.billable ?? true;

  static String _trimHours(double h) =>
      h == h.roundToDouble() ? h.toStringAsFixed(0) : h.toString();

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
      id: Value(widget.entry?.id ?? repo.newId()),
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
          Text(
              widget.entry == null
                  ? l10n.dashboardQuickTime
                  : l10n.commonEdit,
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
