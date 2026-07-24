import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/common.dart';
import '../../core/widgets/labels.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final clients = ref.watch(clientsProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navClients)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showClientEditor(context, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.commonAdd),
      ),
      body: SafeArea(
        child: clients.isEmpty
            ? EmptyState(
                icon: Icons.people_outline,
                message: l10n.commonEmpty,
                action: FilledButton.icon(
                  onPressed: () => showClientEditor(context, null),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.commonAdd),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: clients.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final c = clients[i];
                  final treatment = VatTreatment.byName(c.defaultVatTreatment);
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(c.name.isEmpty ? '?' : c.name[0].toUpperCase()),
                      ),
                      title: Text(c.name),
                      subtitle: Text([
                        if (c.city.isNotEmpty) c.city,
                        c.country,
                        _treatmentLabel(l10n, treatment),
                      ].join(' · ')),
                      trailing: Text(c.language.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall),
                      onTap: () => context.go('/clients/${c.id}'),
                    ),
                  );
                },
              ),
      ),
    );
  }

}

/// Opens the client add/edit bottom sheet. Public so the client detail screen
/// can reuse it.
void showClientEditor(BuildContext context, Client? client) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ClientEditor(client: client),
  );
}

String _treatmentLabel(L10n l10n, VatTreatment t) => vatTreatmentLabel(l10n, t);

class _ClientEditor extends ConsumerStatefulWidget {
  const _ClientEditor({this.client});
  final Client? client;
  @override
  ConsumerState<_ClientEditor> createState() => _ClientEditorState();
}

class _ClientEditorState extends ConsumerState<_ClientEditor> {
  late final _name = TextEditingController(text: widget.client?.name ?? '');
  late final _contact =
      TextEditingController(text: widget.client?.contactName ?? '');
  late final _vatId = TextEditingController(text: widget.client?.vatId ?? '');
  late final _addr =
      TextEditingController(text: widget.client?.addressLine1 ?? '');
  late final _city = TextEditingController(text: widget.client?.city ?? '');
  late final _country =
      TextEditingController(text: widget.client?.country ?? 'Netherlands');
  late final _email = TextEditingController(text: widget.client?.email ?? '');
  late final _rate = TextEditingController(
      text: widget.client?.defaultHourlyRate?.toString() ?? '');
  late String _language = widget.client?.language ?? 'nl';
  late final String _currency = widget.client?.defaultCurrency ?? 'EUR';
  late VatTreatment _treatment = widget.client == null
      ? VatTreatment.reverseChargeEu
      : VatTreatment.byName(widget.client!.defaultVatTreatment);
  late final int _terms = widget.client?.paymentTermDays ?? 30;

  @override
  void dispose() {
    for (final c in [_name, _contact, _vatId, _addr, _city, _country, _email, _rate]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    final repo = ref.read(repositoryProvider);
    final id = widget.client?.id ?? repo.newId();
    await repo.upsertClient(ClientsCompanion(
      id: Value(id),
      name: Value(_name.text.trim()),
      contactName: Value(_contact.text.trim()),
      vatId: Value(_vatId.text.trim()),
      addressLine1: Value(_addr.text.trim()),
      city: Value(_city.text.trim()),
      country: Value(_country.text.trim()),
      email: Value(_email.text.trim()),
      language: Value(_language),
      defaultCurrency: Value(_currency),
      defaultVatTreatment: Value(_treatment.name),
      defaultHourlyRate: Value(double.tryParse(_rate.text.trim())),
      paymentTermDays: Value(_terms),
    ));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.client == null ? l10n.commonAdd : l10n.commonEdit,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Client name')),
            const SizedBox(height: 12),
            TextField(
                controller: _contact,
                decoration: const InputDecoration(labelText: 'Contact person')),
            const SizedBox(height: 12),
            TextField(
                controller: _vatId,
                decoration: InputDecoration(labelText: l10n.invoiceVatId)),
            const SizedBox(height: 12),
            TextField(
                controller: _addr,
                decoration: const InputDecoration(labelText: 'Address')),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                  child: TextField(
                      controller: _city,
                      decoration: const InputDecoration(labelText: 'City'))),
              const SizedBox(width: 12),
              Expanded(
                  child: TextField(
                      controller: _country,
                      decoration:
                          const InputDecoration(labelText: 'Country'))),
            ]),
            const SizedBox(height: 12),
            TextField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            DropdownButtonFormField<VatTreatment>(
              initialValue: _treatment,
              isExpanded: true,
              decoration:
                  const InputDecoration(labelText: 'Default VAT treatment'),
              items: [
                for (final t in VatTreatment.values)
                  DropdownMenuItem(
                    value: t,
                    child: Text(_treatmentLabel(l10n, t),
                        overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (v) =>
                  setState(() => _treatment = v ?? VatTreatment.reverseChargeEu),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _language,
                  decoration:
                      InputDecoration(labelText: l10n.settingsLanguage),
                  items: [
                    for (final lang in AppLanguage.values)
                      DropdownMenuItem(
                          value: lang.code, child: Text(lang.nativeName)),
                  ],
                  onChanged: (v) => setState(() => _language = v ?? 'nl'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _rate,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Hourly rate'),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }
}
