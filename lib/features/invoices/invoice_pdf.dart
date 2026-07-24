import 'dart:typed_data';

import 'package:flutter/widgets.dart' show Locale;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/format/formatters.dart';
import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/labels.dart';
import '../../data/db/database.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';

/// Generates the client-facing invoice PDF.
///
/// The document is rendered in the *invoice's* language (which may differ from
/// the app UI language) using the client's locale, and embeds Noto Sans JP so
/// Japanese, Dutch and English all render from a single font — no tofu.
abstract final class InvoicePdf {
  static const _brand = PdfColor.fromInt(0xFF1F6F5C);
  static const _muted = PdfColor.fromInt(0xFF6B7280);
  static const _line = PdfColor.fromInt(0xFFD1D5DB);

  static Future<void> shareInvoice({
    required BusinessProfile profile,
    required Client client,
    required Invoice invoice,
    required List<InvoiceLine> lines,
  }) async {
    final bytes = await build(
      profile: profile,
      client: client,
      invoice: invoice,
      lines: lines,
    );
    await Printing.sharePdf(bytes: bytes, filename: '${invoice.number}.pdf');
  }

  static Future<Uint8List> build({
    required BusinessProfile profile,
    required Client client,
    required Invoice invoice,
    required List<InvoiceLine> lines,
  }) async {
    final l = await L10n.delegate.load(Locale(invoice.language));
    final fmt = Formatters(invoice.language);
    final currency = Currency.fromCode(invoice.currency);

    final base = await PdfGoogleFonts.notoSansJPRegular();
    final bold = await PdfGoogleFonts.notoSansJPBold();
    final theme = pw.ThemeData.withFont(base: base, bold: bold);

    final doc = pw.Document(theme: theme, title: invoice.number);

    String money(int minor) => fmt.money(Money(minor, currency));
    final treatments =
        lines.map((ln) => VatTreatment.byName(ln.vatTreatment)).toSet();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(40, 44, 40, 40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _header(l, fmt, profile, invoice),
            pw.SizedBox(height: 24),
            _billTo(l, client),
            pw.SizedBox(height: 20),
            _lineTable(l, lines, currency, money),
            pw.SizedBox(height: 12),
            _totals(l, invoice, money),
            pw.SizedBox(height: 18),
            for (final t in treatments)
              if (t.isZeroRated)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text(vatTreatmentNote(l, t),
                      style: pw.TextStyle(
                          fontSize: 8.5,
                          color: _muted,
                          fontStyle: pw.FontStyle.italic)),
                ),
            pw.Spacer(),
            _footer(l, fmt, profile, invoice),
            if (invoice.notes.isNotEmpty) ...[
              pw.SizedBox(height: 12),
              pw.Text(invoice.notes,
                  style: const pw.TextStyle(fontSize: 8.5, color: _muted)),
            ],
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Text(l.invoiceThankYou,
                  style: const pw.TextStyle(fontSize: 9, color: _muted)),
            ),
          ],
        ),
      ),
    );

    return doc.save();
  }

  static pw.Widget _header(
      L10n l, Formatters fmt, BusinessProfile p, Invoice inv) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                p.tradeName.isNotEmpty ? p.tradeName : p.legalName,
                style: pw.TextStyle(
                    fontSize: 15, fontWeight: pw.FontWeight.bold, color: _brand),
              ),
              pw.SizedBox(height: 4),
              if (p.addressLine1.isNotEmpty) _small(p.addressLine1),
              _small('${p.postalCode} ${p.city}'.trim()),
              _small(p.country),
              if (p.email.isNotEmpty) _small(p.email),
              if (p.kvkNumber.isNotEmpty) _small('${l.invoiceKvk}: ${p.kvkNumber}'),
              if (p.vatId.isNotEmpty) _small('${l.invoiceVatId}: ${p.vatId}'),
              if (p.jpBusinessNumber.isNotEmpty) _small(p.jpBusinessNumber),
            ],
          ),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(l.invoiceTitle.toUpperCase(),
                style: pw.TextStyle(
                    fontSize: 26, fontWeight: pw.FontWeight.bold, color: _brand)),
            pw.SizedBox(height: 8),
            _metaRow(l.invoiceNumber, inv.number),
            _metaRow(l.invoiceIssueDate, fmt.date(inv.issueDate)),
            _metaRow(l.invoiceDueDate, fmt.date(inv.dueDate)),
            if (inv.purchaseOrder.isNotEmpty)
              _metaRow(l.invoicePurchaseOrder, inv.purchaseOrder),
          ],
        ),
      ],
    );
  }

  static pw.Widget _billTo(L10n l, Client c) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(l.invoiceBillTo.toUpperCase(),
            style: pw.TextStyle(
                fontSize: 8, fontWeight: pw.FontWeight.bold, color: _muted)),
        pw.SizedBox(height: 4),
        pw.Text(c.name,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
        if (c.addressLine1.isNotEmpty) _small(c.addressLine1),
        _small('${c.postalCode} ${c.city}'.trim()),
        _small(c.country),
        if (c.vatId.isNotEmpty) _small('${l.invoiceVatId}: ${c.vatId}'),
      ],
    );
  }

  static pw.Widget _lineTable(L10n l, List<InvoiceLine> lines, Currency currency,
      String Function(int) money) {
    String qty(double q) =>
        q == q.roundToDouble() ? q.toStringAsFixed(0) : q.toString();

    return pw.TableHelper.fromTextArray(
      border: null,
      headerDecoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _brand, width: 1.2)),
      ),
      headerStyle: pw.TextStyle(
          fontSize: 9, fontWeight: pw.FontWeight.bold, color: _brand),
      cellStyle: const pw.TextStyle(fontSize: 9.5),
      cellPadding: const pw.EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      headerAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FlexColumnWidth(5),
        1: const pw.FlexColumnWidth(1.5),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
      },
      headers: [
        l.invoiceDescription,
        l.invoiceQuantity,
        l.invoiceUnitPrice,
        l.invoiceLineTotal,
      ],
      data: [
        for (final ln in lines)
          [
            ln.description,
            qty(ln.quantity),
            money(ln.unitPriceMinor),
            money(Money(ln.unitPriceMinor, currency).times(ln.quantity).minorUnits),
          ],
      ],
    );
  }

  static pw.Widget _totals(L10n l, Invoice inv, String Function(int) money) {
    return pw.Row(
      children: [
        pw.Spacer(flex: 3),
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            children: [
              _totalRow(l.commonNet, money(inv.subtotalMinor)),
              if (inv.taxMinor != 0)
                _totalRow(l.commonTax, money(inv.taxMinor)),
              pw.Divider(color: _line, height: 10),
              _totalRow(l.commonTotal, money(inv.totalMinor), bold: true),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _footer(
      L10n l, Formatters fmt, BusinessProfile p, Invoice inv) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: _line)),
      ),
      padding: const pw.EdgeInsets.only(top: 12),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(l.invoicePaymentDetails.toUpperCase(),
                    style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                        color: _muted)),
                pw.SizedBox(height: 4),
                if (p.bankName.isNotEmpty) _small(p.bankName),
                if (p.iban.isNotEmpty) _small('IBAN: ${p.iban}'),
                if (p.bic.isNotEmpty) _small('BIC: ${p.bic}'),
                pw.SizedBox(height: 6),
                pw.Text(l.invoicePaymentDue(fmt.date(inv.dueDate)),
                    style: pw.TextStyle(
                        fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.Column(
            children: [
              pw.SizedBox(height: 24),
              pw.Container(width: 150, height: 0.8, color: _muted),
              pw.SizedBox(height: 3),
              pw.Text(l.invoiceSignature,
                  style: const pw.TextStyle(fontSize: 8, color: _muted)),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _metaRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(
                text: '$label  ',
                style: const pw.TextStyle(fontSize: 8.5, color: _muted)),
            pw.TextSpan(
                text: value,
                style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static pw.Widget _totalRow(String label, String value, {bool bold = false}) {
    final style = pw.TextStyle(
      fontSize: bold ? 12 : 9.5,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: bold ? _brand : PdfColors.black,
    );
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(label, style: style)),
          pw.Text(value, style: style),
        ],
      ),
    );
  }

  static pw.Widget _small(String s) =>
      pw.Text(s, style: const pw.TextStyle(fontSize: 9, color: _muted));
}
