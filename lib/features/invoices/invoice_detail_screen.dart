import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/common.dart';
import '../../core/widgets/labels.dart';
import '../../data/db/database.dart';
import '../../data/providers.dart';
import '../../domain/enums.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';
import 'invoice_pdf.dart';

class InvoiceDetailScreen extends ConsumerWidget {
  const InvoiceDetailScreen({super.key, required this.invoiceId});
  final String invoiceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final fmt = ref.watch(formattersProvider);
    final invoice = ref.watch(invoiceProvider(invoiceId)).value;
    final lines = ref.watch(invoiceLinesProvider(invoiceId)).value ?? const [];
    final profile = ref.watch(businessProfileProvider).value;

    if (invoice == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/invoices'),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final client = ref.watch(clientProvider(invoice.clientId)).value;
    final currency = Currency.fromCode(invoice.currency);
    final status = InvoiceStatus.byName(invoice.status);
    final wide = MediaQuery.sizeOf(context).width >= 760;
    final onExport = profile == null || client == null
        ? null
        : () => InvoicePdf.shareInvoice(
              profile: profile,
              client: client,
              invoice: invoice,
              lines: lines,
            );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/invoices'),
        ),
        title: Text(invoice.number),
        actions: [
          PopupMenuButton<InvoiceStatus>(
            tooltip: invoiceStatusLabel(l10n, status),
            icon: const Icon(Icons.flag_outlined),
            onSelected: (s) => ref.read(repositoryProvider).setInvoiceStatus(
                  invoice.id,
                  s.name,
                  paidDate: s == InvoiceStatus.paid ? DateTime.now() : null,
                ),
            itemBuilder: (_) => [
              for (final s in InvoiceStatus.values)
                PopupMenuItem(value: s, child: Text(invoiceStatusLabel(l10n, s))),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.commonEdit,
            onPressed: () => context.go('/invoices/${invoice.id}/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final ok = await confirmDeleteDialog(
                context,
                message: '${l10n.commonDelete}?',
                cancelLabel: l10n.commonCancel,
                deleteLabel: l10n.commonDelete,
              );
              if (ok && context.mounted) {
                await ref.read(repositoryProvider).deleteInvoice(invoice.id);
                if (context.mounted) context.go('/invoices');
              }
            },
          ),
          if (wide)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilledButton.icon(
                onPressed: onExport,
                icon: const Icon(Icons.picture_as_pdf),
                label: Text(l10n.commonExportPdf),
              ),
            )
          else
            IconButton(
              onPressed: onExport,
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: l10n.commonExportPdf,
            ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(context, wide, invoice, lines, client, profile,
            currency, status, l10n, fmt),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool wide,
    Invoice invoice,
    List<InvoiceLine> lines,
    Client? client,
    BusinessProfile? profile,
    Currency currency,
    InvoiceStatus status,
    L10n l10n,
    dynamic fmt,
  ) {
    final document = Card(
      child: Padding(
        padding: EdgeInsets.all(wide ? 28 : 20),
        child: _InvoiceBody(
          invoice: invoice,
          lines: lines,
          client: client,
          profile: profile,
          currency: currency,
          l10n: l10n,
          fmt: fmt,
        ),
      ),
    );

    if (wide) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _StatusBanner(status: status, l10n: l10n),
              const SizedBox(height: 12),
              document,
            ],
          ),
        ),
      );
    }

    // Phone: render the invoice at a comfortable document width and let it
    // scroll horizontally, so it reads like the desktop layout instead of
    // cramming four columns into ~340px.
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _StatusBanner(status: status, l10n: l10n),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(width: 720, child: document),
        ),
      ],
    );
  }

}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.status, required this.l10n});
  final InvoiceStatus status;
  final L10n l10n;

  @override
  Widget build(BuildContext context) {
    final (color, _) = switch (status) {
      InvoiceStatus.paid => (Colors.green, 0),
      InvoiceStatus.overdue => (Colors.red, 0),
      InvoiceStatus.sent => (Colors.blue, 0),
      _ => (Theme.of(context).colorScheme.outline, 0),
    };
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(invoiceStatusLabel(l10n, status),
            style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _InvoiceBody extends StatelessWidget {
  const _InvoiceBody({
    required this.invoice,
    required this.lines,
    required this.client,
    required this.profile,
    required this.currency,
    required this.l10n,
    required this.fmt,
  });

  final Invoice invoice;
  final List<InvoiceLine> lines;
  final Client? client;
  final BusinessProfile? profile;
  final Currency currency;
  final L10n l10n;
  final dynamic fmt;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final treatments =
        lines.map((l) => VatTreatment.byName(l.vatTreatment)).toSet();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      profile?.tradeName.isNotEmpty == true
                          ? profile!.tradeName
                          : (profile?.legalName ?? ''),
                      style: text.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  if (profile != null) _addr(profile!, text),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(l10n.invoiceTitle.toUpperCase(),
                    style: text.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                _meta(l10n.invoiceNumber, invoice.number, text),
                _meta(l10n.invoiceIssueDate, fmt.date(invoice.issueDate), text),
                if (invoice.dueDateEnabled)
                  _meta(l10n.invoiceDueDate, fmt.date(invoice.dueDate), text),
                if (invoice.purchaseOrder.isNotEmpty)
                  _meta(l10n.invoicePurchaseOrder, invoice.purchaseOrder, text),
              ],
            ),
          ],
        ),
        const Divider(height: 40),
        Text(l10n.invoiceBillTo, style: text.labelMedium),
        const SizedBox(height: 4),
        if (client != null) ...[
          Text(client!.name,
              style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          if (client!.addressLine1.isNotEmpty) Text(client!.addressLine1),
          Text('${client!.postalCode} ${client!.city}'.trim()),
          Text(client!.country),
          if (client!.vatId.isNotEmpty)
            Text('${l10n.invoiceVatId}: ${client!.vatId}'),
        ],
        const SizedBox(height: 24),
        _LineTable(lines: lines, currency: currency, l10n: l10n, fmt: fmt),
        const SizedBox(height: 12),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: 280,
            child: Column(
              children: [
                _totalRow(l10n.commonNet, Money(invoice.subtotalMinor, currency),
                    fmt, text),
                if (invoice.taxMinor != 0)
                  _totalRow(l10n.commonTax, Money(invoice.taxMinor, currency),
                      fmt, text),
                const Divider(),
                _totalRow(l10n.commonTotal, Money(invoice.totalMinor, currency),
                    fmt, text,
                    bold: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        for (final t in treatments)
          if (t.isZeroRated)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(vatTreatmentNote(l10n, t),
                  style: text.bodySmall
                      ?.copyWith(fontStyle: FontStyle.italic)),
            ),
        const Divider(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.invoicePaymentDetails, style: text.labelMedium),
            const SizedBox(height: 4),
            if (profile?.bankName.isNotEmpty == true) Text(profile!.bankName),
            if (profile?.iban.isNotEmpty == true) Text('IBAN: ${profile!.iban}'),
            if (profile?.bic.isNotEmpty == true) Text('BIC: ${profile!.bic}'),
            if (invoice.dueDateEnabled) ...[
              const SizedBox(height: 6),
              Text(l10n.invoicePaymentDue(fmt.date(invoice.dueDate)),
                  style:
                      text.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ],
        ),
        const SizedBox(height: 24),
        // Mirrors the PDF: each rule sits under the name and address of the
        // party who signs it — ours on the left, the client's on the right.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _signatureBlock(
                role: l10n.invoiceSignature,
                name: switch (profile) {
                  null => '',
                  final p when p.tradeName.isNotEmpty => p.tradeName,
                  final p => p.legalName,
                },
                address: [
                  if (profile?.addressLine1.isNotEmpty == true)
                    profile!.addressLine1,
                  '${profile?.postalCode ?? ''} ${profile?.city ?? ''}'.trim(),
                  profile?.country ?? '',
                ],
                text: text,
              ),
            ),
            const SizedBox(width: 28),
            Expanded(
              child: _signatureBlock(
                role: l10n.invoiceSignatureClient,
                name: client?.name ?? '',
                address: [
                  if (client?.addressLine1.isNotEmpty == true)
                    client!.addressLine1,
                  '${client?.postalCode ?? ''} ${client?.city ?? ''}'.trim(),
                  client?.country ?? '',
                ],
                text: text,
              ),
            ),
          ],
        ),
        if (invoice.notes.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(invoice.notes, style: text.bodySmall),
        ],
      ],
    );
  }

  /// A signature block: who signs, their address, then the line they sign on.
  /// Naming the party above the rule keeps a countersigned copy unambiguous.
  Widget _signatureBlock({
    required String role,
    required String name,
    required List<String> address,
    required TextTheme text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(role.toUpperCase(), style: text.labelSmall),
        const SizedBox(height: 4),
        Text(name,
            style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        for (final line in address)
          if (line.isNotEmpty) Text(line, style: text.bodySmall),
        const SizedBox(height: 32),
        Container(height: 1, color: Colors.grey),
      ],
    );
  }

  Widget _addr(BusinessProfile p, TextTheme text) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (p.addressLine1.isNotEmpty) Text(p.addressLine1, style: text.bodySmall),
          Text('${p.postalCode} ${p.city}'.trim(), style: text.bodySmall),
          Text(p.country, style: text.bodySmall),
          if (p.kvkNumber.isNotEmpty)
            Text('${l10n.invoiceKvk}: ${p.kvkNumber}', style: text.bodySmall),
          if (p.vatId.isNotEmpty)
            Text('${l10n.invoiceVatId}: ${p.vatId}', style: text.bodySmall),
        ],
      );

  Widget _meta(String label, String value, TextTheme text) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Text('$label: $value', style: text.bodySmall),
      );

  Widget _totalRow(String label, Money amount, dynamic fmt, TextTheme text,
      {bool bold = false}) {
    final style = bold
        ? text.titleMedium?.copyWith(fontWeight: FontWeight.w800)
        : text.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(fmt.money(amount), style: style),
        ],
      ),
    );
  }
}

class _LineTable extends StatelessWidget {
  const _LineTable(
      {required this.lines,
      required this.currency,
      required this.l10n,
      required this.fmt});
  final List<InvoiceLine> lines;
  final Currency currency;
  final L10n l10n;
  final dynamic fmt;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(5),
        1: FlexColumnWidth(1.4),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant))),
          children: [
            _h(l10n.invoiceDescription, text),
            _h(l10n.invoiceQuantity, text, end: true),
            _h(l10n.invoiceUnitPrice, text, end: true),
            _h(l10n.invoiceLineTotal, text, end: true),
          ],
        ),
        for (final line in lines)
          TableRow(children: [
            _cell(line.description, text),
            _cell(_qty(line.quantity), text, end: true),
            _cell(fmt.money(Money(line.unitPriceMinor, currency)), text,
                end: true),
            _cell(
                fmt.money(Money(line.unitPriceMinor, currency).times(line.quantity)),
                text,
                end: true),
          ]),
      ],
    );
  }

  String _qty(double q) =>
      q == q.roundToDouble() ? q.toStringAsFixed(0) : q.toString();

  Widget _h(String s, TextTheme text, {bool end = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(s,
            textAlign: end ? TextAlign.end : TextAlign.start,
            style: text.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
      );

  Widget _cell(String s, TextTheme text, {bool end = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(s,
            textAlign: end ? TextAlign.end : TextAlign.start,
            style: text.bodyMedium),
      );
}
