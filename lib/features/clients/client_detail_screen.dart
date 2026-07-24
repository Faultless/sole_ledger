import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/common.dart';
import '../../core/widgets/labels.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';
import 'clients_screen.dart';

class ClientDetailScreen extends ConsumerWidget {
  const ClientDetailScreen({super.key, required this.clientId});
  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final client = ref.watch(clientProvider(clientId)).value;
    final projects = ref.watch(projectsProvider(clientId)).value ?? const [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/clients'),
        ),
        title: Text(client?.name ?? l10n.clientDetails),
        actions: [
          if (client != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => showClientEditor(context, client),
            ),
        ],
      ),
      floatingActionButton: client == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openProjectEditor(context, clientId, null),
              icon: const Icon(Icons.add),
              label: Text(l10n.projectsTitle),
            ),
      body: client == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kv(context, l10n.invoiceBillTo, [
                            client.name,
                            if (client.addressLine1.isNotEmpty) client.addressLine1,
                            '${client.postalCode} ${client.city}'.trim(),
                            client.country,
                          ].where((s) => s.trim().isNotEmpty).join('\n')),
                          if (client.vatId.isNotEmpty)
                            _kv(context, l10n.invoiceVatId, client.vatId),
                          _kv(
                              context,
                              'VAT',
                              vatTreatmentLabel(l10n,
                                  VatTreatment.byName(client.defaultVatTreatment))),
                          _kv(context, l10n.settingsLanguage,
                              client.language.toUpperCase()),
                          if (client.defaultHourlyRate != null)
                            _kv(context, l10n.projectRate,
                                '${client.defaultCurrency} ${client.defaultHourlyRate}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SectionHeader(title: l10n.projectsTitle),
                  if (projects.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(l10n.commonEmpty,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    )
                  else
                    for (final p in projects)
                      Card(
                        child: ListTile(
                          leading: Icon(p.active
                              ? Icons.folder_outlined
                              : Icons.folder_off_outlined),
                          title: Text(p.name),
                          subtitle: p.hourlyRate == null
                              ? null
                              : Text(
                                  '${p.currency ?? client.defaultCurrency} ${p.hourlyRate}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () =>
                                ref.read(repositoryProvider).deleteProject(p.id),
                          ),
                          onTap: () =>
                              _openProjectEditor(context, clientId, p),
                        ),
                      ),
                ],
              ),
            ),
    );
  }

  Widget _kv(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  void _openProjectEditor(
      BuildContext context, String clientId, Project? project) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ProjectEditor(clientId: clientId, project: project),
    );
  }
}

class _ProjectEditor extends ConsumerStatefulWidget {
  const _ProjectEditor({required this.clientId, this.project});
  final String clientId;
  final Project? project;
  @override
  ConsumerState<_ProjectEditor> createState() => _ProjectEditorState();
}

class _ProjectEditorState extends ConsumerState<_ProjectEditor> {
  late final _name = TextEditingController(text: widget.project?.name ?? '');
  late final _rate =
      TextEditingController(text: widget.project?.hourlyRate?.toString() ?? '');
  late bool _active = widget.project?.active ?? true;

  @override
  void dispose() {
    _name.dispose();
    _rate.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    final repo = ref.read(repositoryProvider);
    await repo.upsertProject(ProjectsCompanion(
      id: Value(widget.project?.id ?? repo.newId()),
      clientId: Value(widget.clientId),
      name: Value(_name.text.trim()),
      hourlyRate: Value(double.tryParse(_rate.text.replaceAll(',', '.').trim())),
      active: Value(_active),
    ));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.project == null ? l10n.commonAdd : l10n.commonEdit,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: l10n.projectName),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _rate,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.projectRate),
          ),
          const SizedBox(height: 4),
          SwitchListTile(
            value: _active,
            onChanged: (v) => setState(() => _active = v),
            title: Text(l10n.projectActive),
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
