/// The jurisdiction whose tax regime a treatment belongs to.
enum TaxJurisdiction { eu, netherlands, japan, none }

/// How VAT / consumption tax is applied to an invoice line or an entire
/// invoice.
///
/// The default for this business (Dutch eenmanszaak, operator tax-resident in
/// Japan, invoicing Dutch/EU business clients) is [reverseChargeEu]: the
/// service is invoiced at 0% and the business client self-accounts for VAT.
/// See [labelKey] / [noteKey] for the localized wording each treatment must
/// print on the invoice.
///
/// IMPORTANT: rates and eligibility are jurisdiction rules, not app opinions.
/// The user confirms the applicable treatment per client with their
/// accountant / 税理士; the app only renders the chosen treatment correctly.
enum VatTreatment {
  /// EU B2B reverse charge. 0% on the invoice, client accounts for VAT.
  /// Requires the client's VAT identification number to be shown.
  reverseChargeEu(
    ratePercent: 0,
    jurisdiction: TaxJurisdiction.eu,
    requiresClientVatId: true,
    printsReverseChargeStatement: true,
    labelKey: 'vatReverseChargeEuLabel',
    noteKey: 'vatReverseChargeEuNote',
  ),

  /// Export of services from Japan to an overseas client: consumption-tax
  /// exempt (輸出免税). 0% on the invoice.
  exportExemptJp(
    ratePercent: 0,
    jurisdiction: TaxJurisdiction.japan,
    requiresClientVatId: false,
    printsReverseChargeStatement: false,
    labelKey: 'vatExportExemptJpLabel',
    noteKey: 'vatExportExemptJpNote',
  ),

  /// Standard Dutch VAT (BTW) 21%.
  standardNl21(
    ratePercent: 21,
    jurisdiction: TaxJurisdiction.netherlands,
    requiresClientVatId: false,
    printsReverseChargeStatement: false,
    labelKey: 'vatStandardNl21Label',
    noteKey: 'vatStandardNlNote',
  ),

  /// Reduced Dutch VAT (BTW) 9%.
  reducedNl9(
    ratePercent: 9,
    jurisdiction: TaxJurisdiction.netherlands,
    requiresClientVatId: false,
    printsReverseChargeStatement: false,
    labelKey: 'vatReducedNl9Label',
    noteKey: 'vatStandardNlNote',
  ),

  /// Standard Japanese consumption tax (消費税) 10%.
  standardJp10(
    ratePercent: 10,
    jurisdiction: TaxJurisdiction.japan,
    requiresClientVatId: false,
    printsReverseChargeStatement: false,
    labelKey: 'vatStandardJp10Label',
    noteKey: 'vatStandardJpNote',
  ),

  /// Small-business / exempt supplier: KOR (NL) or 免税事業者 (JP). 0%,
  /// no VAT charged and none reclaimable.
  smallBusinessExempt(
    ratePercent: 0,
    jurisdiction: TaxJurisdiction.none,
    requiresClientVatId: false,
    printsReverseChargeStatement: false,
    labelKey: 'vatSmallBusinessLabel',
    noteKey: 'vatSmallBusinessNote',
  ),

  /// No VAT applies / out of scope.
  none(
    ratePercent: 0,
    jurisdiction: TaxJurisdiction.none,
    requiresClientVatId: false,
    printsReverseChargeStatement: false,
    labelKey: 'vatNoneLabel',
    noteKey: 'vatNoneNote',
  );

  const VatTreatment({
    required this.ratePercent,
    required this.jurisdiction,
    required this.requiresClientVatId,
    required this.printsReverseChargeStatement,
    required this.labelKey,
    required this.noteKey,
  });

  /// Whole-number percentage (e.g. 21 for 21%).
  final int ratePercent;
  final TaxJurisdiction jurisdiction;

  /// Whether the client's VAT ID must be present and printed for this
  /// treatment to be valid.
  final bool requiresClientVatId;

  /// Whether a reverse-charge statement must be printed on the invoice.
  final bool printsReverseChargeStatement;

  /// i18n key for the short label shown in the tax column / summary.
  final String labelKey;

  /// i18n key for the longer explanatory note printed on the invoice.
  final String noteKey;

  /// Tax rate as a fraction for arithmetic (0.21 for 21%).
  double get rateFraction => ratePercent / 100.0;

  bool get isZeroRated => ratePercent == 0;

  static VatTreatment byName(String name) => VatTreatment.values.firstWhere(
        (t) => t.name == name,
        orElse: () => VatTreatment.reverseChargeEu,
      );
}
