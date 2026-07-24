import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/format/formatters.dart';
import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/widgets/labels.dart';
import '../../data/db/database.dart';
import '../../domain/tax/jp_income_tax.dart';
import '../../domain/tax/period_report.dart';
import '../../l10n/app_localizations.dart';

/// Official portals referenced from the reports.
abstract final class Portals {
  static const nlVat = 'https://mijn.belastingdienst.nl/zakelijk';
  static const jpETax = 'https://www.e-tax.nta.go.jp/';
  static const kvk = 'https://www.kvk.nl';
}

abstract final class ReportPdf {
  static const _brand = PdfColor.fromInt(0xFF1F6F5C);
  static const _muted = PdfColor.fromInt(0xFF6B7280);
  static const _line = PdfColor.fromInt(0xFFD1D5DB);

  static Future<pw.ThemeData> _theme() async => pw.ThemeData.withFont(
        base: await PdfGoogleFonts.notoSansJPRegular(),
        bold: await PdfGoogleFonts.notoSansJPBold(),
      );

  /// Official letterhead: full business identity on the left, report title and
  /// period on the right. Uses whatever the user has filled in Settings.
  static pw.Widget _letterhead(
      BusinessProfile p, L10n l, String title, String period) {
    final name = p.tradeName.isNotEmpty ? p.tradeName : p.legalName;
    final cityLine = '${p.postalCode} ${p.city}'.trim();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (name.isNotEmpty)
                    pw.Text(name,
                        style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: _brand)),
                  pw.SizedBox(height: 3),
                  if (p.addressLine1.isNotEmpty) _small(p.addressLine1),
                  if (p.addressLine2.isNotEmpty) _small(p.addressLine2),
                  if (cityLine.isNotEmpty) _small(cityLine),
                  if (p.country.isNotEmpty) _small(p.country),
                  if (p.email.isNotEmpty) _small(p.email),
                  if (p.phone.isNotEmpty) _small(p.phone),
                  pw.SizedBox(height: 2),
                  if (p.kvkNumber.isNotEmpty)
                    _small('${l.invoiceKvk}: ${p.kvkNumber}'),
                  if (p.vatId.isNotEmpty)
                    _small('${l.invoiceVatId}: ${p.vatId}'),
                  if (p.jpBusinessNumber.isNotEmpty) _small(p.jpBusinessNumber),
                ],
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(title,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: _brand)),
                pw.SizedBox(height: 4),
                pw.Text(period,
                    style: const pw.TextStyle(fontSize: 10, color: _muted)),
              ],
            ),
          ],
        ),
        pw.Divider(color: _line, height: 20),
      ],
    );
  }

  static pw.Widget _small(String s) =>
      pw.Text(s, style: const pw.TextStyle(fontSize: 8.5, color: _muted));

  static pw.Widget _generatedOn(L10n l, Formatters fmt) => pw.Text(
        l.reportGeneratedOn(fmt.date(DateTime.now())),
        style: const pw.TextStyle(fontSize: 8, color: _muted),
      );

  static pw.Widget _portalNote(String label, String url) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 4),
        child: pw.RichText(
          text: pw.TextSpan(children: [
            pw.TextSpan(
                text: '$label  ',
                style: const pw.TextStyle(fontSize: 8.5, color: _muted)),
            pw.TextSpan(
                text: url,
                style: const pw.TextStyle(
                    fontSize: 8.5, color: PdfColor.fromInt(0xFF1F6F5C))),
          ]),
        ),
      );

  // ---------------------------------------------------------------- Timesheet

  static Future<void> shareTimesheet({
    required BusinessProfile profile,
    required List<Client> clients,
    required List<TimeEntry> entries,
    required DateTime from,
    required DateTime toInclusive,
    required String lang,
  }) async {
    final l = await L10n.delegate.load(Locale(lang));
    final fmt = Formatters(lang);
    final names = {for (final c in clients) c.id: c.name};
    final byClient = <String, List<TimeEntry>>{};
    for (final e in entries) {
      byClient.putIfAbsent(e.clientId, () => []).add(e);
    }
    final grandMinutes = entries.fold<int>(0, (s, e) => s + e.minutes);

    final doc = pw.Document(theme: await _theme(), title: l.reportTimesheet);
    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) => [
        _letterhead(profile, l, l.reportTimesheet,
            '${fmt.date(from)} – ${fmt.date(toInclusive)}'),
        for (final entry in byClient.entries) ...[
          pw.SizedBox(height: 6),
          pw.Text(names[entry.key] ?? '—',
              style: pw.TextStyle(
                  fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.TableHelper.fromTextArray(
            border: null,
            headerStyle: pw.TextStyle(
                fontSize: 8.5, fontWeight: pw.FontWeight.bold, color: _muted),
            cellStyle: const pw.TextStyle(fontSize: 9.5),
            cellAlignments: {0: pw.Alignment.centerLeft, 2: pw.Alignment.centerRight},
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(1.5),
            },
            headers: [l.invoiceIssueDate, l.invoiceDescription, l.commonHours],
            data: [
              for (final e in entry.value)
                [
                  fmt.dateNumeric(e.date),
                  e.description,
                  fmt.hoursFromMinutes(e.minutes),
                ],
            ],
          ),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.Text(
                '${l.commonTotal}: ${fmt.hoursFromMinutes(entry.value.fold<int>(0, (s, e) => s + e.minutes))}',
                style: pw.TextStyle(
                    fontSize: 9.5, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ),
        ],
        pw.Divider(color: _line, height: 24),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            '${l.commonTotal}: ${fmt.hoursFromMinutes(grandMinutes)}',
            style: pw.TextStyle(
                fontSize: 12, fontWeight: pw.FontWeight.bold, color: _brand),
          ),
        ),
        pw.SizedBox(height: 16),
        _generatedOn(l, fmt),
      ],
    ));
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'timesheet.pdf');
  }

  static Future<void> saveTimesheetMarkdown({
    required BusinessProfile profile,
    required List<Client> clients,
    required List<TimeEntry> entries,
    required DateTime from,
    required DateTime toInclusive,
    required String lang,
  }) async {
    final fmt = Formatters(lang);
    final names = {for (final c in clients) c.id: c.name};
    final byClient = <String, List<TimeEntry>>{};
    for (final e in entries) {
      byClient.putIfAbsent(e.clientId, () => []).add(e);
    }
    final name =
        profile.tradeName.isNotEmpty ? profile.tradeName : profile.legalName;
    final idLines = <String>[
      if (profile.addressLine1.isNotEmpty) profile.addressLine1,
      if ('${profile.postalCode} ${profile.city}'.trim().isNotEmpty)
        '${profile.postalCode} ${profile.city}'.trim(),
      if (profile.country.isNotEmpty) profile.country,
      if (profile.email.isNotEmpty) profile.email,
      if (profile.kvkNumber.isNotEmpty) 'KvK: ${profile.kvkNumber}',
      if (profile.vatId.isNotEmpty) 'VAT: ${profile.vatId}',
    ];
    final buffer = StringBuffer()
      ..writeln('# Timesheet')
      ..writeln()
      ..writeln('**$name**')
      ..writeln();
    for (final line in idLines) {
      buffer.writeln('$line  ');
    }
    buffer
      ..writeln()
      ..writeln('Period: ${fmt.date(from)} – ${fmt.date(toInclusive)}')
      ..writeln();
    var grand = 0;
    byClient.forEach((clientId, list) {
      final minutes = list.fold<int>(0, (s, e) => s + e.minutes);
      grand += minutes;
      buffer
        ..writeln('## ${names[clientId] ?? '—'}')
        ..writeln()
        ..writeln('| Date | Description | Hours |')
        ..writeln('|------|-------------|------:|');
      for (final e in list) {
        buffer.writeln(
            '| ${fmt.dateNumeric(e.date)} | ${e.description.replaceAll('|', '\\|')} | ${fmt.hoursFromMinutes(e.minutes)} |');
      }
      buffer
        ..writeln('| | **Subtotal** | **${fmt.hoursFromMinutes(minutes)}** |')
        ..writeln();
    });
    buffer.writeln('**Total: ${fmt.hoursFromMinutes(grand)}**');
    await _saveMarkdown('timesheet', buffer.toString());
  }

  // -------------------------------------------------------------- Quarterly VAT

  static Future<void> shareQuarterlyVat({
    required BusinessProfile profile,
    required VatReport report,
    required int year,
    required int quarter,
    required String lang,
  }) async {
    final l = await L10n.delegate.load(Locale(lang));
    final fmt = Formatters(lang);
    final doc = pw.Document(theme: await _theme(), title: l.reportQuarterlyVat);

    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) => [
        _letterhead(profile, l, l.reportQuarterlyVat, '$year · Q$quarter'),
        for (final currency in report.currencies) ...[
          pw.SizedBox(height: 8),
          pw.Text(currency.code,
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.TableHelper.fromTextArray(
            border: null,
            headerDecoration: const pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: _brand, width: 1))),
            headerStyle: pw.TextStyle(
                fontSize: 9, fontWeight: pw.FontWeight.bold, color: _brand),
            cellStyle: const pw.TextStyle(fontSize: 9.5),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
              2: pw.Alignment.centerRight,
            },
            columnWidths: {
              0: const pw.FlexColumnWidth(5),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
            },
            headers: ['VAT treatment', l.commonNet, l.commonTax],
            data: [
              for (final b in report.forCurrency(currency))
                [
                  vatTreatmentLabel(l, b.treatment),
                  fmt.money(b.net),
                  fmt.money(b.tax),
                ],
              [
                l.commonTotal,
                fmt.money(report.netTotal(currency)),
                fmt.money(report.taxTotal(currency)),
              ],
            ],
          ),
        ],
        pw.Divider(color: _line, height: 24),
        pw.Text(l.settingsTaxDisclaimer,
            style: const pw.TextStyle(fontSize: 8, color: _muted)),
        pw.SizedBox(height: 8),
        _portalNote('Belastingdienst (BTW):', Portals.nlVat),
        _portalNote('NTA e-Tax:', Portals.jpETax),
        pw.SizedBox(height: 8),
        _generatedOn(l, fmt),
      ],
    ));
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'vat_${year}_Q$quarter.pdf');
  }

  // ------------------------------------------------------------- Annual income

  static Future<void> shareAnnualIncome({
    required BusinessProfile profile,
    required IncomeReport report,
    required int year,
    required String lang,
    required double eurToJpy,
  }) async {
    final l = await L10n.delegate.load(Locale(lang));
    final fmt = Formatters(lang);
    final doc = pw.Document(theme: await _theme(), title: l.reportAnnualIncome);

    // Convert each currency's net to JPY for the income-tax estimate.
    var taxableJpy = 0;
    for (final c in report.currencies) {
      final net = report.netOf(c).asMajor;
      final jpy = switch (c) {
        Currency.jpy => net,
        Currency.eur => net * eurToJpy,
        Currency.usd => net * eurToJpy, // treated via EUR rate as a rough proxy
      };
      taxableJpy += jpy.round();
    }
    final estimate = JpIncomeTaxEstimator.estimate(taxableJpy);
    final jpy = Formatters('ja');
    String yen(int v) => jpy.money(Money(v, Currency.jpy));

    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) => [
        _letterhead(profile, l, l.reportAnnualIncome, '$year'),
        pw.TableHelper.fromTextArray(
          border: null,
          headerStyle: pw.TextStyle(
              fontSize: 9, fontWeight: pw.FontWeight.bold, color: _brand),
          cellStyle: const pw.TextStyle(fontSize: 9.5),
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerRight,
            2: pw.Alignment.centerRight,
            3: pw.Alignment.centerRight,
          },
          headers: [
            l.commonCurrency,
            l.commonRevenue,
            l.commonExpenses,
            l.commonResult,
          ],
          data: [
            for (final c in report.currencies)
              [
                c.code,
                fmt.money(report.revenueOf(c)),
                fmt.money(report.expensesOf(c)),
                fmt.money(report.netOf(c)),
              ],
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: const PdfColor.fromInt(0xFFF1F5F4),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Japanese income-tax estimate (確定申告)',
                  style: pw.TextStyle(
                      fontSize: 11, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 2),
              pw.Text('Result converted at €1 = ¥${eurToJpy.toStringAsFixed(1)}',
                  style: const pw.TextStyle(fontSize: 8, color: _muted)),
              pw.SizedBox(height: 8),
              _estRow('Taxable income (approx.)', yen(estimate.taxableIncome)),
              _estRow(
                  'National income tax (${estimate.appliedRatePercent}% bracket)',
                  yen(estimate.nationalTax)),
              _estRow('Reconstruction surtax (2.1%)',
                  yen(estimate.reconstructionSurtax)),
              _estRow('Residents\' tax (approx. 10%)',
                  yen(estimate.residentsTaxApprox)),
              pw.Divider(color: _line, height: 12),
              _estRow('Estimated total', yen(estimate.totalEstimate),
                  bold: true),
            ],
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Text(l.settingsTaxDisclaimer,
            style: const pw.TextStyle(fontSize: 8, color: _muted)),
        pw.SizedBox(height: 8),
        _portalNote('NTA e-Tax:', Portals.jpETax),
        _portalNote('KvK:', Portals.kvk),
        pw.SizedBox(height: 8),
        _generatedOn(l, fmt),
      ],
    ));
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'income_$year.pdf');
  }

  static pw.Widget _estRow(String label, String value, {bool bold = false}) {
    final style = pw.TextStyle(
        fontSize: bold ? 11 : 9.5,
        fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: bold ? _brand : PdfColors.black);
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(children: [
        pw.Expanded(child: pw.Text(label, style: style)),
        pw.Text(value, style: style),
      ]),
    );
  }

  static Future<void> _saveMarkdown(String name, String content) async {
    await FileSaver.instance.saveFile(
      name: name,
      bytes: Uint8List.fromList(utf8.encode(content)),
      fileExtension: 'md',
      mimeType: MimeType.text,
    );
  }
}
