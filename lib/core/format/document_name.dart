import '../../domain/enums.dart';
import '../../domain/tax/report_period.dart';

/// Builds filenames for exported documents.
///
/// The shape is always `What_Who_When`, e.g.
/// `INV-2026-0001_Frontendienst_DeliHome_Aug_2026.pdf` — the document's own
/// identifier, then the parties, then an abbreviated period. Enough to know
/// what a file is from its name alone, sitting in a folder a year later or
/// attached to an email.
///
/// Deliberately ASCII and English regardless of the document's own language: a
/// filename travels through mail clients, cloud drives and other people's
/// machines, and `Aug_2026` survives that trip in a way a localised month name
/// does not.
abstract final class DocumentName {
  /// `INV-2026-0001_Frontendienst_DeliHome_Aug_2026`
  static String invoice({
    required String number,
    required String issuer,
    required String client,
    required DateTime issueDate,
  }) =>
      _join([
        _clean(number, keepDashes: true),
        _clean(issuer),
        _clean(client),
        monthAbbreviation(issueDate.month),
        '${issueDate.year}',
      ]);

  /// `Timesheet_Frontendienst_Aug_2026` or `Timesheet_Frontendienst_Q3_2026`.
  static String timesheet({
    required String issuer,
    required ReportPeriod period,
  }) =>
      _join(['Timesheet', _clean(issuer), ..._periodParts(period)]);

  /// `VAT_Frontendienst_Q3_2026`
  static String vatReturn({required String issuer, required int year, required Quarter quarter}) =>
      _join(['VAT', _clean(issuer), 'Q${quarter.number}', '$year']);

  /// `Income_Frontendienst_2026`
  static String annualIncome({required String issuer, required int year}) =>
      _join(['Income', _clean(issuer), '$year']);

  static List<String> _periodParts(ReportPeriod period) =>
      switch (period.kind) {
        ReportPeriodKind.month => [
            monthAbbreviation(period.month),
            '${period.year}',
          ],
        ReportPeriodKind.quarter => ['Q${period.quarter.number}', '${period.year}'],
      };

  static String _join(List<String> parts) =>
      parts.where((p) => p.isNotEmpty).join('_');

  /// English three-letter month, 1–12.
  static String monthAbbreviation(int month) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    if (month < 1 || month > 12) return '';
    return names[month - 1];
  }

  /// Legal-entity suffixes dropped from a party name. "Deli Home Netherlands
  /// B.V." is a company; "DeliHomeNetherlands" is what you'd call the file.
  static final _legalSuffixes = {
    'bv', 'nv', 'vof', 'cv', 'bvba', 'ltd', 'limited', 'plc', 'llc', 'llp',
    'inc', 'incorporated', 'corp', 'corporation', 'gmbh', 'ag', 'sa', 'sarl',
    'srl', 'spa', 'ab', 'as', 'oy', 'aps', 'kk', 'eenmanszaak',
    '株式会社', '有限会社', '合同会社',
  };

  /// Common accented Latin letters folded to ASCII. Anything outside this and
  /// the alphanumerics below is dropped.
  static const _fold = {
    'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a', 'æ': 'ae',
    'ç': 'c', 'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e', 'ì': 'i', 'í': 'i',
    'î': 'i', 'ï': 'i', 'ñ': 'n', 'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o',
    'ö': 'o', 'ø': 'o', 'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u', 'ý': 'y',
    'ÿ': 'y', 'ß': 'ss',
  };

  /// Maximum characters kept from any one party name, so a long legal name
  /// can't push the filename past what a mail client will show.
  static const int maxPartLength = 28;

  static String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  /// Turns a party name into one filename-safe word: legal suffix dropped,
  /// accents folded, punctuation removed, words run together in PascalCase.
  ///
  /// Non-Latin scripts keep their letters — a Japanese client's name is more
  /// use in a filename than the empty string stripping it would leave.
  static String _clean(String raw, {bool keepDashes = false}) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return '';

    // Document numbers keep their dashes: INV-2026-0001 is how you refer to it.
    if (keepDashes) {
      final kept =
          trimmed.replaceAll(RegExp(r'[^\p{L}\p{N}-]+', unicode: true), '');
      return kept.length > maxPartLength
          ? kept.substring(0, maxPartLength)
          : kept;
    }

    // Periods go first so an abbreviated form survives as one word: "B.V."
    // must reach the suffix list as "bv", not as "b" and "v".
    final words = trimmed
        .replaceAll('.', '')
        .split(RegExp(r'[^\p{L}\p{N}]+', unicode: true))
        .where((w) => w.isNotEmpty)
        .toList();

    // Only trailing suffixes are dropped, and never the entire name: a client
    // actually called "BV" keeps it.
    while (words.length > 1 &&
        _legalSuffixes.contains(words.last.toLowerCase())) {
      words.removeLast();
    }

    final buffer = StringBuffer();
    for (final word in words) {
      var first = true;
      for (final ch in word.split('')) {
        final folded = _foldChar(ch);
        if (folded.isEmpty) continue;
        // Casing the author chose is kept — an explicit short name like
        // "DeliHome" must not come back as "Delihome" — beyond forcing each
        // word to start capitalised so run-together words stay readable.
        buffer.write(first ? _capitalize(folded) : folded);
        first = false;
      }
    }
    final out = buffer.toString();
    return out.length > maxPartLength ? out.substring(0, maxPartLength) : out;
  }

  /// Folds one character to ASCII where there's a sensible equivalent, keeping
  /// its case. Characters that are neither letters nor digits drop out.
  static String _foldChar(String ch) {
    final lower = ch.toLowerCase();
    final folded = _fold[lower];
    if (folded != null) return ch == lower ? folded : _capitalize(folded);
    return RegExp(r'^[\p{L}\p{N}]$', unicode: true).hasMatch(ch) ? ch : '';
  }
}
