import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('nl'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sole Ledger'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get navTime;

  /// No description provided for @navClients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get navClients;

  /// No description provided for @navInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get navInvoices;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get navExpenses;

  /// No description provided for @navAssets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get navAssets;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @expenseCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get expenseCategory;

  /// No description provided for @expenseDeductible.
  ///
  /// In en, this message translates to:
  /// **'Deductible'**
  String get expenseDeductible;

  /// No description provided for @expenseVatAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT paid'**
  String get expenseVatAmount;

  /// No description provided for @expenseAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get expenseAmount;

  /// No description provided for @receiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receiptTitle;

  /// No description provided for @receiptScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get receiptScan;

  /// No description provided for @receiptAttach.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get receiptAttach;

  /// No description provided for @receiptRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove receipt'**
  String get receiptRemove;

  /// No description provided for @receiptScanning.
  ///
  /// In en, this message translates to:
  /// **'Reading receipt…'**
  String get receiptScanning;

  /// No description provided for @receiptFromScanVerify.
  ///
  /// In en, this message translates to:
  /// **'Filled from scan — please check every value'**
  String get receiptFromScanVerify;

  /// No description provided for @receiptScanNothing.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read any values — please enter them manually'**
  String get receiptScanNothing;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// No description provided for @projectRate.
  ///
  /// In en, this message translates to:
  /// **'Hourly rate (optional)'**
  String get projectRate;

  /// No description provided for @projectActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get projectActive;

  /// No description provided for @clientDetails.
  ///
  /// In en, this message translates to:
  /// **'Client details'**
  String get clientDetails;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get commonExport;

  /// No description provided for @commonExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get commonExportPdf;

  /// No description provided for @commonExportMarkdown.
  ///
  /// In en, this message translates to:
  /// **'Export Markdown'**
  String get commonExportMarkdown;

  /// No description provided for @commonNet.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get commonNet;

  /// No description provided for @commonTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get commonTax;

  /// No description provided for @commonTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get commonTotal;

  /// No description provided for @commonHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get commonHours;

  /// No description provided for @commonCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get commonCurrency;

  /// No description provided for @commonRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue (net)'**
  String get commonRevenue;

  /// No description provided for @commonExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get commonExpenses;

  /// No description provided for @commonResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get commonResult;

  /// No description provided for @commonEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get commonEmpty;

  /// No description provided for @commonSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commonSelect;

  /// No description provided for @commonSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get commonSelectAll;

  /// No description provided for @commonClearSelection.
  ///
  /// In en, this message translates to:
  /// **'Clear selection'**
  String get commonClearSelection;

  /// No description provided for @commonSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String commonSelectedCount(int count);

  /// No description provided for @commonDeleteCountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} items? This can\'t be undone.'**
  String commonDeleteCountConfirm(int count);

  /// No description provided for @commonToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get commonToday;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @dashboardHoursThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Hours this month'**
  String get dashboardHoursThisMonth;

  /// No description provided for @dashboardUnbilled.
  ///
  /// In en, this message translates to:
  /// **'Unbilled'**
  String get dashboardUnbilled;

  /// No description provided for @dashboardOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding invoices'**
  String get dashboardOutstanding;

  /// No description provided for @dashboardQuarterTax.
  ///
  /// In en, this message translates to:
  /// **'Quarter tax set-aside (est.)'**
  String get dashboardQuarterTax;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get dashboardWelcome;

  /// No description provided for @dashboardQuickTime.
  ///
  /// In en, this message translates to:
  /// **'Log time'**
  String get dashboardQuickTime;

  /// No description provided for @dashboardQuickInvoice.
  ///
  /// In en, this message translates to:
  /// **'New invoice'**
  String get dashboardQuickInvoice;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsBusinessProfile.
  ///
  /// In en, this message translates to:
  /// **'Business profile'**
  String get settingsBusinessProfile;

  /// No description provided for @settingsBusinessProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, KvK, VAT ID, bank details, signature'**
  String get settingsBusinessProfileSubtitle;

  /// No description provided for @settingsTaxDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'About the tax figures'**
  String get settingsTaxDisclaimerTitle;

  /// No description provided for @settingsTaxDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Tax amounts shown in this app are estimates to help you plan and prepare filings. They are not tax advice. Confirm your VAT treatment and income-tax position with your accountant (boekhouder) or licensed tax accountant (税理士).'**
  String get settingsTaxDisclaimer;

  /// No description provided for @vatReverseChargeEuLabel.
  ///
  /// In en, this message translates to:
  /// **'VAT reverse-charged'**
  String get vatReverseChargeEuLabel;

  /// No description provided for @vatReverseChargeEuNote.
  ///
  /// In en, this message translates to:
  /// **'VAT reverse-charged under Article 196 of EU Directive 2006/112/EC. The customer is liable to account for VAT.'**
  String get vatReverseChargeEuNote;

  /// No description provided for @vatExportExemptJpLabel.
  ///
  /// In en, this message translates to:
  /// **'Export of services — consumption-tax exempt'**
  String get vatExportExemptJpLabel;

  /// No description provided for @vatExportExemptJpNote.
  ///
  /// In en, this message translates to:
  /// **'Zero-rated export of services under the Japanese Consumption Tax Act; Japanese consumption tax does not apply.'**
  String get vatExportExemptJpNote;

  /// No description provided for @vatStandardNl21Label.
  ///
  /// In en, this message translates to:
  /// **'VAT 21%'**
  String get vatStandardNl21Label;

  /// No description provided for @vatReducedNl9Label.
  ///
  /// In en, this message translates to:
  /// **'VAT 9%'**
  String get vatReducedNl9Label;

  /// No description provided for @vatStandardNlNote.
  ///
  /// In en, this message translates to:
  /// **'Dutch VAT (BTW).'**
  String get vatStandardNlNote;

  /// No description provided for @vatStandardJp10Label.
  ///
  /// In en, this message translates to:
  /// **'Consumption tax 10%'**
  String get vatStandardJp10Label;

  /// No description provided for @vatStandardJpNote.
  ///
  /// In en, this message translates to:
  /// **'Japanese consumption tax (消費税).'**
  String get vatStandardJpNote;

  /// No description provided for @vatSmallBusinessLabel.
  ///
  /// In en, this message translates to:
  /// **'Small-business scheme — VAT exempt'**
  String get vatSmallBusinessLabel;

  /// No description provided for @vatSmallBusinessNote.
  ///
  /// In en, this message translates to:
  /// **'Supplier applies the small-business exemption; no VAT is charged.'**
  String get vatSmallBusinessNote;

  /// No description provided for @vatNoneLabel.
  ///
  /// In en, this message translates to:
  /// **'No VAT'**
  String get vatNoneLabel;

  /// No description provided for @vatNoneNote.
  ///
  /// In en, this message translates to:
  /// **'No VAT applies to this supply.'**
  String get vatNoneNote;

  /// No description provided for @invoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceTitle;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice number'**
  String get invoiceNumber;

  /// No description provided for @invoiceIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue date'**
  String get invoiceIssueDate;

  /// No description provided for @invoiceDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get invoiceDueDate;

  /// No description provided for @invoiceDueDateEnabled.
  ///
  /// In en, this message translates to:
  /// **'Set a due date'**
  String get invoiceDueDateEnabled;

  /// No description provided for @invoiceBillTo.
  ///
  /// In en, this message translates to:
  /// **'Bill to'**
  String get invoiceBillTo;

  /// No description provided for @invoiceFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get invoiceFrom;

  /// No description provided for @invoiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get invoiceDescription;

  /// No description provided for @invoiceQuantity.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get invoiceQuantity;

  /// No description provided for @invoiceUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get invoiceUnitPrice;

  /// No description provided for @invoiceLineTotal.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get invoiceLineTotal;

  /// No description provided for @invoicePaymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get invoicePaymentDetails;

  /// No description provided for @invoicePaymentDue.
  ///
  /// In en, this message translates to:
  /// **'Payment due by {date}'**
  String invoicePaymentDue(String date);

  /// No description provided for @invoiceThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your business.'**
  String get invoiceThankYou;

  /// No description provided for @invoiceSignature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get invoiceSignature;

  /// No description provided for @invoiceSignatureClient.
  ///
  /// In en, this message translates to:
  /// **'Signature (client)'**
  String get invoiceSignatureClient;

  /// No description provided for @invoiceKvk.
  ///
  /// In en, this message translates to:
  /// **'KvK'**
  String get invoiceKvk;

  /// No description provided for @invoiceVatId.
  ///
  /// In en, this message translates to:
  /// **'VAT ID'**
  String get invoiceVatId;

  /// No description provided for @invoicePurchaseOrder.
  ///
  /// In en, this message translates to:
  /// **'PO number'**
  String get invoicePurchaseOrder;

  /// No description provided for @reportTimesheet.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
  String get reportTimesheet;

  /// No description provided for @reportQuarterlyVat.
  ///
  /// In en, this message translates to:
  /// **'Quarterly VAT figures'**
  String get reportQuarterlyVat;

  /// No description provided for @reportAnnualIncome.
  ///
  /// In en, this message translates to:
  /// **'Annual income statement'**
  String get reportAnnualIncome;

  /// No description provided for @reportPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get reportPeriod;

  /// No description provided for @reportGeneratedOn.
  ///
  /// In en, this message translates to:
  /// **'Generated on {date}'**
  String reportGeneratedOn(String date);

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get statusSent;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get statusOverdue;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'ja':
      return L10nJa();
    case 'nl':
      return L10nNl();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
