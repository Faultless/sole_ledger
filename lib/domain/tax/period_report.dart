import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import 'vat_treatment.dart';

/// A priced line for reporting: net amount + treatment (from an invoice line).
class ReportLine {
  const ReportLine({required this.net, required this.treatment});
  final Money net;
  final VatTreatment treatment;
}

/// Net + output-VAT for one (currency, treatment) bucket.
class VatBucket {
  VatBucket(this.currency, this.treatment);
  final Currency currency;
  final VatTreatment treatment;
  int _net = 0;

  void addNet(int minor) => _net += minor;

  Money get net => Money(_net, currency);
  Money get tax => net.taxAt(treatment.rateFraction);
  Money get gross => net + tax;
}

/// VAT summary over a period, grouped by currency then treatment. Suitable for
/// a Dutch BTW-aangifte cross-check (rubriek-style breakdown) and to show what
/// was reverse-charged / zero-rated.
class VatReport {
  VatReport(this.buckets);
  final List<VatBucket> buckets;

  Iterable<Currency> get currencies =>
      buckets.map((b) => b.currency).toSet();

  List<VatBucket> forCurrency(Currency c) =>
      buckets.where((b) => b.currency == c).toList();

  Money netTotal(Currency c) =>
      sumMoney(forCurrency(c).map((b) => b.net), c);
  Money taxTotal(Currency c) =>
      sumMoney(forCurrency(c).map((b) => b.tax), c);

  static VatReport fromLines(Iterable<ReportLine> lines) {
    final map = <(Currency, VatTreatment), VatBucket>{};
    for (final l in lines) {
      final key = (l.net.currency, l.treatment);
      final bucket = map.putIfAbsent(
          key, () => VatBucket(l.net.currency, l.treatment));
      bucket.addNet(l.net.minorUnits);
    }
    return VatReport(map.values.toList());
  }
}

/// Revenue vs. expenses for a period, per currency. Revenue is *net* (excl.
/// VAT). Net result feeds the income-tax picture (JP 確定申告).
class IncomeReport {
  IncomeReport({required this.revenue, required this.expenses});

  /// currency -> net revenue (minor units)
  final Map<Currency, int> revenue;

  /// currency -> deductible expenses (minor units)
  final Map<Currency, int> expenses;

  Iterable<Currency> get currencies =>
      {...revenue.keys, ...expenses.keys};

  Money revenueOf(Currency c) => Money(revenue[c] ?? 0, c);
  Money expensesOf(Currency c) => Money(expenses[c] ?? 0, c);
  Money netOf(Currency c) => Money((revenue[c] ?? 0) - (expenses[c] ?? 0), c);
}
