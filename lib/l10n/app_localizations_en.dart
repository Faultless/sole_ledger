// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sole Ledger';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navTime => 'Time';

  @override
  String get navClients => 'Clients';

  @override
  String get navInvoices => 'Invoices';

  @override
  String get navReports => 'Reports';

  @override
  String get navExpenses => 'Expenses';

  @override
  String get navAssets => 'Assets';

  @override
  String get navSettings => 'Settings';

  @override
  String get expenseCategory => 'Category';

  @override
  String get expenseDeductible => 'Deductible';

  @override
  String get expenseVatAmount => 'VAT paid';

  @override
  String get expenseAmount => 'Amount';

  @override
  String get receiptTitle => 'Receipt';

  @override
  String get receiptScan => 'Scan';

  @override
  String get receiptAttach => 'Attach';

  @override
  String get receiptRemove => 'Remove receipt';

  @override
  String get receiptScanning => 'Reading receipt…';

  @override
  String get receiptFromScanVerify =>
      'Filled from scan — please check every value';

  @override
  String get receiptScanNothing =>
      'Couldn\'t read any values — please enter them manually';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get projectName => 'Project name';

  @override
  String get projectRate => 'Hourly rate (optional)';

  @override
  String get projectActive => 'Active';

  @override
  String get clientDetails => 'Client details';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonClose => 'Close';

  @override
  String get commonExport => 'Export';

  @override
  String get commonExportPdf => 'Export PDF';

  @override
  String get commonExportMarkdown => 'Export Markdown';

  @override
  String get commonNet => 'Net';

  @override
  String get commonTax => 'Tax';

  @override
  String get commonTotal => 'Total';

  @override
  String get commonHours => 'Hours';

  @override
  String get commonCurrency => 'Currency';

  @override
  String get commonRevenue => 'Revenue (net)';

  @override
  String get commonExpenses => 'Expenses';

  @override
  String get commonResult => 'Result';

  @override
  String get commonEmpty => 'Nothing here yet';

  @override
  String get commonSelect => 'Select';

  @override
  String get commonSelectAll => 'Select all';

  @override
  String get commonClearSelection => 'Clear selection';

  @override
  String commonSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String commonDeleteCountConfirm(int count) {
    return 'Delete $count items? This can\'t be undone.';
  }

  @override
  String get commonToday => 'Today';

  @override
  String get dashboardHoursThisMonth => 'Hours this month';

  @override
  String get dashboardUnbilled => 'Unbilled';

  @override
  String get dashboardOutstanding => 'Outstanding invoices';

  @override
  String get dashboardQuarterTax => 'Quarter tax set-aside (est.)';

  @override
  String get dashboardWelcome => 'Welcome back';

  @override
  String get dashboardQuickTime => 'Log time';

  @override
  String get dashboardQuickInvoice => 'New invoice';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsBusinessProfile => 'Business profile';

  @override
  String get settingsBusinessProfileSubtitle =>
      'Name, KvK, VAT ID, bank details, signature';

  @override
  String get settingsTaxDisclaimerTitle => 'About the tax figures';

  @override
  String get settingsTaxDisclaimer =>
      'Tax amounts shown in this app are estimates to help you plan and prepare filings. They are not tax advice. Confirm your VAT treatment and income-tax position with your accountant (boekhouder) or licensed tax accountant (税理士).';

  @override
  String get vatReverseChargeEuLabel => 'VAT reverse-charged';

  @override
  String get vatReverseChargeEuNote =>
      'VAT reverse-charged under Article 196 of EU Directive 2006/112/EC. The customer is liable to account for VAT.';

  @override
  String get vatExportExemptJpLabel =>
      'Export of services — consumption-tax exempt';

  @override
  String get vatExportExemptJpNote =>
      'Zero-rated export of services under the Japanese Consumption Tax Act; Japanese consumption tax does not apply.';

  @override
  String get vatStandardNl21Label => 'VAT 21%';

  @override
  String get vatReducedNl9Label => 'VAT 9%';

  @override
  String get vatStandardNlNote => 'Dutch VAT (BTW).';

  @override
  String get vatStandardJp10Label => 'Consumption tax 10%';

  @override
  String get vatStandardJpNote => 'Japanese consumption tax (消費税).';

  @override
  String get vatSmallBusinessLabel => 'Small-business scheme — VAT exempt';

  @override
  String get vatSmallBusinessNote =>
      'Supplier applies the small-business exemption; no VAT is charged.';

  @override
  String get vatNoneLabel => 'No VAT';

  @override
  String get vatNoneNote => 'No VAT applies to this supply.';

  @override
  String get invoiceTitle => 'Invoice';

  @override
  String get invoiceNumber => 'Invoice number';

  @override
  String get invoiceIssueDate => 'Issue date';

  @override
  String get invoiceDueDate => 'Due date';

  @override
  String get invoiceBillTo => 'Bill to';

  @override
  String get invoiceFrom => 'From';

  @override
  String get invoiceDescription => 'Description';

  @override
  String get invoiceQuantity => 'Qty';

  @override
  String get invoiceUnitPrice => 'Unit price';

  @override
  String get invoiceLineTotal => 'Amount';

  @override
  String get invoicePaymentDetails => 'Payment details';

  @override
  String invoicePaymentDue(String date) {
    return 'Payment due by $date';
  }

  @override
  String get invoiceThankYou => 'Thank you for your business.';

  @override
  String get invoiceSignature => 'Signature';

  @override
  String get invoiceKvk => 'KvK';

  @override
  String get invoiceVatId => 'VAT ID';

  @override
  String get invoicePurchaseOrder => 'PO number';

  @override
  String get reportTimesheet => 'Timesheet';

  @override
  String get reportQuarterlyVat => 'Quarterly VAT figures';

  @override
  String get reportAnnualIncome => 'Annual income statement';

  @override
  String get reportPeriod => 'Period';

  @override
  String reportGeneratedOn(String date) {
    return 'Generated on $date';
  }

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusSent => 'Sent';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get statusCancelled => 'Cancelled';
}
