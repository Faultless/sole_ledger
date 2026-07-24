// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class L10nNl extends L10n {
  L10nNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Sole Ledger';

  @override
  String get navDashboard => 'Overzicht';

  @override
  String get navTime => 'Uren';

  @override
  String get navClients => 'Klanten';

  @override
  String get navInvoices => 'Facturen';

  @override
  String get navReports => 'Rapporten';

  @override
  String get navExpenses => 'Kosten';

  @override
  String get navSettings => 'Instellingen';

  @override
  String get expenseCategory => 'Categorie';

  @override
  String get expenseDeductible => 'Aftrekbaar';

  @override
  String get expenseVatAmount => 'Betaalde btw';

  @override
  String get expenseAmount => 'Bedrag';

  @override
  String get receiptTitle => 'Bon';

  @override
  String get receiptScan => 'Scannen';

  @override
  String get receiptAttach => 'Toevoegen';

  @override
  String get receiptRemove => 'Bon verwijderen';

  @override
  String get receiptScanning => 'Bon wordt gelezen…';

  @override
  String get receiptFromScanVerify =>
      'Ingevuld via scan — controleer elke waarde';

  @override
  String get receiptScanNothing =>
      'Geen waarden herkend — voer ze handmatig in';

  @override
  String get projectsTitle => 'Projecten';

  @override
  String get projectName => 'Projectnaam';

  @override
  String get projectRate => 'Uurtarief (optioneel)';

  @override
  String get projectActive => 'Actief';

  @override
  String get clientDetails => 'Klantgegevens';

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonCancel => 'Annuleren';

  @override
  String get commonDelete => 'Verwijderen';

  @override
  String get commonEdit => 'Bewerken';

  @override
  String get commonAdd => 'Toevoegen';

  @override
  String get commonClose => 'Sluiten';

  @override
  String get commonExport => 'Exporteren';

  @override
  String get commonExportPdf => 'Pdf exporteren';

  @override
  String get commonExportMarkdown => 'Markdown exporteren';

  @override
  String get commonNet => 'Netto';

  @override
  String get commonTax => 'Btw';

  @override
  String get commonTotal => 'Totaal';

  @override
  String get commonHours => 'Uren';

  @override
  String get commonCurrency => 'Valuta';

  @override
  String get commonRevenue => 'Omzet (netto)';

  @override
  String get commonExpenses => 'Kosten';

  @override
  String get commonResult => 'Resultaat';

  @override
  String get commonEmpty => 'Nog niets hier';

  @override
  String get dashboardHoursThisMonth => 'Uren deze maand';

  @override
  String get dashboardUnbilled => 'Nog te factureren';

  @override
  String get dashboardOutstanding => 'Openstaande facturen';

  @override
  String get dashboardQuarterTax =>
      'Reservering belasting kwartaal (schatting)';

  @override
  String get dashboardWelcome => 'Welkom terug';

  @override
  String get dashboardQuickTime => 'Uren registreren';

  @override
  String get dashboardQuickInvoice => 'Nieuwe factuur';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageSystem => 'Systeemstandaard';

  @override
  String get settingsBusinessProfile => 'Bedrijfsprofiel';

  @override
  String get settingsBusinessProfileSubtitle =>
      'Naam, KvK, btw-id, bankgegevens, handtekening';

  @override
  String get settingsTaxDisclaimerTitle => 'Over de belastingcijfers';

  @override
  String get settingsTaxDisclaimer =>
      'De belastingbedragen in deze app zijn schattingen om te plannen en aangiftes voor te bereiden. Het is geen belastingadvies. Bevestig uw btw-behandeling en inkomstenbelastingpositie met uw boekhouder of belastingadviseur (税理士).';

  @override
  String get vatReverseChargeEuLabel => 'Btw verlegd';

  @override
  String get vatReverseChargeEuNote =>
      'Btw verlegd op grond van artikel 196 van EU-richtlijn 2006/112/EG. De afnemer is de btw verschuldigd.';

  @override
  String get vatExportExemptJpLabel => 'Uitvoer van diensten — vrijgesteld';

  @override
  String get vatExportExemptJpNote =>
      'Nultarief voor uitvoer van diensten op grond van de Japanse Wet op de verbruiksbelasting; Japanse verbruiksbelasting is niet van toepassing.';

  @override
  String get vatStandardNl21Label => 'Btw 21%';

  @override
  String get vatReducedNl9Label => 'Btw 9%';

  @override
  String get vatStandardNlNote => 'Nederlandse btw.';

  @override
  String get vatStandardJp10Label => 'Verbruiksbelasting 10%';

  @override
  String get vatStandardJpNote => 'Japanse verbruiksbelasting (消費税).';

  @override
  String get vatSmallBusinessLabel => 'Kleineondernemersregeling (KOR)';

  @override
  String get vatSmallBusinessNote =>
      'Leverancier past de kleineondernemersregeling toe; er wordt geen btw in rekening gebracht.';

  @override
  String get vatNoneLabel => 'Geen btw';

  @override
  String get vatNoneNote => 'Op deze levering is geen btw van toepassing.';

  @override
  String get invoiceTitle => 'Factuur';

  @override
  String get invoiceNumber => 'Factuurnummer';

  @override
  String get invoiceIssueDate => 'Factuurdatum';

  @override
  String get invoiceDueDate => 'Vervaldatum';

  @override
  String get invoiceBillTo => 'Factuuradres';

  @override
  String get invoiceFrom => 'Van';

  @override
  String get invoiceDescription => 'Omschrijving';

  @override
  String get invoiceQuantity => 'Aantal';

  @override
  String get invoiceUnitPrice => 'Prijs per stuk';

  @override
  String get invoiceLineTotal => 'Bedrag';

  @override
  String get invoicePaymentDetails => 'Betaalgegevens';

  @override
  String invoicePaymentDue(String date) {
    return 'Te betalen vóór $date';
  }

  @override
  String get invoiceThankYou => 'Bedankt voor uw opdracht.';

  @override
  String get invoiceSignature => 'Handtekening';

  @override
  String get invoiceKvk => 'KvK';

  @override
  String get invoiceVatId => 'Btw-id';

  @override
  String get invoicePurchaseOrder => 'Inkoopordernummer';

  @override
  String get reportTimesheet => 'Urenstaat';

  @override
  String get reportQuarterlyVat => 'Btw-cijfers per kwartaal';

  @override
  String get reportAnnualIncome => 'Jaarlijkse winst-en-verliesrekening';

  @override
  String get reportPeriod => 'Periode';

  @override
  String reportGeneratedOn(String date) {
    return 'Gegenereerd op $date';
  }

  @override
  String get statusDraft => 'Concept';

  @override
  String get statusSent => 'Verzonden';

  @override
  String get statusPaid => 'Betaald';

  @override
  String get statusOverdue => 'Verlopen';

  @override
  String get statusCancelled => 'Geannuleerd';
}
