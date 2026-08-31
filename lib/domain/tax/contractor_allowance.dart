import '../../core/money/money.dart';

/// How the contractor tax allowance is derived from the invoice net.
///
/// The distinction matters more than it looks. A surcharge of r% does *not*
/// leave you with the net once you reserve r% of what you receive, because the
/// allowance is itself business revenue and so is taxed too. Gross-up solves
/// for that; surcharge is the simpler commercial framing.
enum AllowanceMode {
  /// allowance = net × r. The invoice total is net × (1 + r).
  ///
  /// Reserving r% of the *total* then leaves less than [net]: at r = 21% on a
  /// €2,520 net, the total is €3,049.20, the reserve €640.33, and you keep
  /// €2,408.87 — an effective reserve of 17.4% of the total, not 21%.
  surcharge,

  /// allowance = net × r / (1 − r). The invoice total is net / (1 − r).
  ///
  /// Reserving r% of the total leaves exactly [net]: at r = 21% on a €2,520
  /// net, the total is €3,189.87, the reserve €669.87, and you keep €2,520.00.
  grossUp;

  static AllowanceMode byName(String name) => AllowanceMode.values.firstWhere(
        (m) => m.name == name,
        orElse: () => AllowanceMode.surcharge,
      );
}

/// A contractual uplift covering the contractor's own tax burden.
///
/// This is deliberately NOT a [VatTreatment]: no government levies it, none of
/// it is remitted to a tax authority, and it must never be presented to the
/// client as VAT. It is part of the agreed fee — and therefore part of your
/// business revenue, taxed like the rest of it (see [AllowanceMode]).
class ContractorAllowance {
  const ContractorAllowance({
    required this.enabled,
    required this.ratePercent,
    required this.mode,
  });

  /// An allowance that adds nothing — the state of every invoice written
  /// before this feature existed.
  static const none = ContractorAllowance(
    enabled: false,
    ratePercent: 0,
    mode: AllowanceMode.surcharge,
  );

  final bool enabled;

  /// Whole-or-fractional percentage, e.g. 25 or 27.5.
  final double ratePercent;
  final AllowanceMode mode;

  /// Rate clamped to a sane band. Gross-up diverges as the rate approaches
  /// 100% (you cannot gross up past giving everything away), and neither mode
  /// has a meaning below zero, so both ends are pinned rather than allowed to
  /// produce nonsense totals.
  double get effectiveRatePercent => switch (ratePercent) {
        final r when r.isNaN => 0,
        final r when r < 0 => 0,
        final r when r > _maxRatePercent => _maxRatePercent,
        final r => r,
      };

  static const double _maxRatePercent = 99;

  double get rateFraction => effectiveRatePercent / 100.0;

  bool get isZero => !enabled || effectiveRatePercent == 0;

  /// The uplift to add to [net]. Rounded once, here — the single place this
  /// arithmetic rounds, matching how VAT is rounded per group rather than per
  /// line.
  Money amountOn(Money net) {
    if (isZero) return Money.zero(net.currency);
    final r = rateFraction;
    return switch (mode) {
      AllowanceMode.surcharge => net.taxAt(r),
      AllowanceMode.grossUp => net.grossUpPortionAt(r),
    };
  }

  ContractorAllowance copyWith({
    bool? enabled,
    double? ratePercent,
    AllowanceMode? mode,
  }) =>
      ContractorAllowance(
        enabled: enabled ?? this.enabled,
        ratePercent: ratePercent ?? this.ratePercent,
        mode: mode ?? this.mode,
      );
}
