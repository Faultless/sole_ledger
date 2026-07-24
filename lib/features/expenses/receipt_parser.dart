/// Heuristic extraction of bookkeeping fields from raw OCR text.
///
/// This is deliberately a *best-effort assistant*, never authoritative: receipt
/// layouts vary wildly across NL and JP merchants, and OCR is noisy. Everything
/// it returns is meant to pre-fill the expense editor for the user to verify —
/// see [ScannedReceipt]. Kept pure Dart (no plugins) so it is unit-testable.
library;

/// Values guessed from a scanned receipt. Any field may be null when the parser
/// isn't confident. Amounts are in major units (e.g. 12.34), matching the
/// editor's text fields.
class ScannedReceipt {
  const ScannedReceipt({
    this.amountMajor,
    this.vatMajor,
    this.vatRate,
    this.date,
    this.currency,
    this.vendor,
  });

  final double? amountMajor;
  final double? vatMajor;
  final int? vatRate;
  final DateTime? date;
  final String? currency; // 'EUR' | 'JPY'
  final String? vendor;

  bool get isEmpty =>
      amountMajor == null &&
      vatMajor == null &&
      date == null &&
      vendor == null;
}

// Keywords whose line usually carries the grand total (case-insensitive; JP is
// matched as-is since it has no case).
const _totalKeywords = [
  'total', 'totaal', 'te betalen', 'amount due', 'balance due', 'grand total',
  '合計', '税込', 'お会計', 'ご請求', '請求金額', 'お買上げ',
];

// Lines we must NOT read a total from (change given, cash tendered, subtotals).
const _totalExclusions = [
  'subtotal', 'subtotaal', 'change', 'wisselgeld', 'cash', 'contant',
  'お釣り', 'おつり', '釣り', '預り', 'お預り', '現金', '小計',
];

const _vatKeywords = [
  'btw', 'vat', 'tax', '消費税', '内税', '外税', '税額', '税',
];

/// Parses [rawText] (all lines ML Kit returned) into a [ScannedReceipt].
ScannedReceipt parseReceiptText(String rawText) {
  final lines = rawText
      .split(RegExp(r'[\r\n]+'))
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .toList();
  final lower = rawText.toLowerCase();

  final currency = _detectCurrency(rawText, lower);
  final date = _detectDate(lines);
  final vatRate = _detectVatRate(rawText);
  final amount = _detectTotal(lines, currency);
  final vat = _detectVat(lines, currency);
  final vendor = _detectVendor(lines);

  return ScannedReceipt(
    amountMajor: amount,
    vatMajor: vat,
    vatRate: vatRate,
    date: date,
    currency: currency,
    vendor: vendor,
  );
}

String? _detectCurrency(String raw, String lower) {
  if (raw.contains('€') || RegExp(r'\beur\b').hasMatch(lower)) return 'EUR';
  if (raw.contains('¥') || raw.contains('円') || RegExp(r'\bjpy\b').hasMatch(lower)) {
    return 'JPY';
  }
  return null;
}

int? _detectVatRate(String raw) {
  // Prefer explicit VAT-ish rates over any stray percentage.
  for (final r in [21, 10, 9, 8]) {
    if (RegExp('(?<!\\d)$r\\s*%').hasMatch(raw)) return r;
  }
  return null;
}

double? _detectTotal(List<String> lines, String? currency) {
  final candidates = <double>[];
  for (final line in lines) {
    final l = line.toLowerCase();
    if (_totalExclusions.any(l.contains)) continue;
    if (_totalKeywords.any((k) => l.contains(k.toLowerCase()))) {
      final amounts = _amountsIn(line, currency);
      if (amounts.isNotEmpty) {
        candidates.add(amounts.reduce((a, b) => a > b ? a : b));
      }
    }
  }
  if (candidates.isNotEmpty) {
    return candidates.reduce((a, b) => a > b ? a : b);
  }
  // Fallback: the largest money-looking number on the receipt is usually the
  // total. Exclude lines we know aren't totals.
  final all = <double>[];
  for (final line in lines) {
    if (_totalExclusions.any(line.toLowerCase().contains)) continue;
    all.addAll(_amountsIn(line, currency));
  }
  if (all.isEmpty) return null;
  return all.reduce((a, b) => a > b ? a : b);
}

double? _detectVat(List<String> lines, String? currency) {
  for (final line in lines) {
    final l = line.toLowerCase();
    if (_vatKeywords.any((k) => l.contains(k.toLowerCase()))) {
      final amounts = _amountsIn(line, currency);
      // A percentage sign alone (e.g. "BTW 21%") isn't a money amount; take the
      // largest remaining number, which is the VAT value when present.
      if (amounts.isNotEmpty) return amounts.reduce((a, b) => a > b ? a : b);
    }
  }
  return null;
}

String? _detectVendor(List<String> lines) {
  for (final line in lines) {
    // First line with letters that isn't obviously a number/date/address code.
    if (RegExp(r'[A-Za-z぀-ヿ一-鿿]{3,}').hasMatch(line) &&
        !RegExp(r'^\d').hasMatch(line)) {
      return line.length > 60 ? line.substring(0, 60) : line;
    }
  }
  return null;
}

/// Extracts money-looking numbers from a single line. When [currency] is JPY
/// (no minor units), separators are treated as thousands so "¥1,200" → 1200.
List<double> _amountsIn(String line, String? currency) {
  final out = <double>[];
  // Money tokens: optional currency symbol, digits with , . separators.
  final re = RegExp(r'(?:[€¥]\s*)?\d[\d.,]*\d|\d');
  for (final m in re.allMatches(line)) {
    // A number immediately followed by '%' is a rate (e.g. "BTW 9%"), not money.
    if (RegExp(r'^\s*%').hasMatch(line.substring(m.end))) continue;
    final token = m.group(0)!.replaceAll(RegExp(r'[€¥\s]'), '');
    final value = _parseAmount(token, isJpy: currency == 'JPY');
    if (value != null && value > 0) out.add(value);
  }
  return out;
}

/// Normalises a numeric token to a double, disambiguating European
/// (1.234,56) vs Anglo (1,234.56) vs JPY (1,200 = thousands) grouping.
double? _parseAmount(String token, {required bool isJpy}) {
  if (!RegExp(r'\d').hasMatch(token)) return null;
  final hasComma = token.contains(',');
  final hasDot = token.contains('.');

  String normalised;
  if (isJpy) {
    // Yen has no minor units: every separator is a thousands group.
    normalised = token.replaceAll(RegExp(r'[.,]'), '');
  } else if (hasComma && hasDot) {
    // The rightmost separator is the decimal point; strip the other as grouping.
    final decimalSep = token.lastIndexOf(',') > token.lastIndexOf('.') ? ',' : '.';
    final groupSep = decimalSep == ',' ? '.' : ',';
    normalised = token.replaceAll(groupSep, '').replaceAll(decimalSep, '.');
  } else if (hasComma || hasDot) {
    final sep = hasComma ? ',' : '.';
    final parts = token.split(sep);
    // A single separator with exactly 3 trailing digits is thousands grouping
    // (1.234 / 1,234); 1 or 2 trailing digits is a decimal fraction.
    if (parts.length == 2 && parts[1].length == 3) {
      normalised = token.replaceAll(sep, '');
    } else {
      normalised = token.replaceAll(sep, '.');
    }
  } else {
    normalised = token;
  }
  return double.tryParse(normalised);
}

/// Finds the first plausible date across NL/ISO/JP formats.
DateTime? _detectDate(List<String> lines) {
  final raw = lines.join('\n');

  // yyyy年mm月dd日 (Japanese)
  final jp = RegExp(r'(\d{4})\s*年\s*(\d{1,2})\s*月\s*(\d{1,2})\s*日').firstMatch(raw);
  if (jp != null) {
    return _clampDate(int.parse(jp[1]!), int.parse(jp[2]!), int.parse(jp[3]!));
  }

  // yyyy-mm-dd or yyyy/mm/dd (ISO / common JP)
  final iso = RegExp(r'(\d{4})[/\-.](\d{1,2})[/\-.](\d{1,2})').firstMatch(raw);
  if (iso != null) {
    return _clampDate(int.parse(iso[1]!), int.parse(iso[2]!), int.parse(iso[3]!));
  }

  // dd-mm-yyyy or dd/mm/yyyy or dd.mm.yyyy (NL/EU)
  final eu = RegExp(r'(\d{1,2})[/\-.](\d{1,2})[/\-.](\d{4})').firstMatch(raw);
  if (eu != null) {
    return _clampDate(int.parse(eu[3]!), int.parse(eu[2]!), int.parse(eu[1]!));
  }

  // dd-mm-yy (two-digit year) — assume 2000s
  final eu2 = RegExp(r'(?<!\d)(\d{1,2})[/\-.](\d{1,2})[/\-.](\d{2})(?!\d)')
      .firstMatch(raw);
  if (eu2 != null) {
    return _clampDate(2000 + int.parse(eu2[3]!), int.parse(eu2[2]!), int.parse(eu2[1]!));
  }
  return null;
}

DateTime? _clampDate(int y, int m, int d) {
  if (y < 2000 || y > 2100 || m < 1 || m > 12 || d < 1 || d > 31) return null;
  return DateTime(y, m, d);
}
