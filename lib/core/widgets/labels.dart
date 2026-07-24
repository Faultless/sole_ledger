import '../../domain/enums.dart';
import '../../domain/tax/vat_treatment.dart';
import '../../l10n/app_localizations.dart';

/// Localized short label for a VAT treatment (tax column / dropdowns).
String vatTreatmentLabel(L10n l, VatTreatment t) => switch (t) {
      VatTreatment.reverseChargeEu => l.vatReverseChargeEuLabel,
      VatTreatment.exportExemptJp => l.vatExportExemptJpLabel,
      VatTreatment.standardNl21 => l.vatStandardNl21Label,
      VatTreatment.reducedNl9 => l.vatReducedNl9Label,
      VatTreatment.standardJp10 => l.vatStandardJp10Label,
      VatTreatment.smallBusinessExempt => l.vatSmallBusinessLabel,
      VatTreatment.none => l.vatNoneLabel,
    };

/// Localized full legal note for a VAT treatment (printed on invoices).
String vatTreatmentNote(L10n l, VatTreatment t) => switch (t) {
      VatTreatment.reverseChargeEu => l.vatReverseChargeEuNote,
      VatTreatment.exportExemptJp => l.vatExportExemptJpNote,
      VatTreatment.standardNl21 => l.vatStandardNlNote,
      VatTreatment.reducedNl9 => l.vatStandardNlNote,
      VatTreatment.standardJp10 => l.vatStandardJpNote,
      VatTreatment.smallBusinessExempt => l.vatSmallBusinessNote,
      VatTreatment.none => l.vatNoneNote,
    };

/// Localized invoice status label.
String invoiceStatusLabel(L10n l, InvoiceStatus s) => switch (s) {
      InvoiceStatus.draft => l.statusDraft,
      InvoiceStatus.sent => l.statusSent,
      InvoiceStatus.paid => l.statusPaid,
      InvoiceStatus.overdue => l.statusOverdue,
      InvoiceStatus.cancelled => l.statusCancelled,
    };
