/// Business-expense categories for a Japanese sole proprietor filing a blue
/// return (青色申告), mapped to the standard account headings (勘定科目).
///
/// Each carries a sensible default business-use percentage (家事按分) and a
/// short deductibility hint, so the expense editor can pre-fill the right
/// apportionment and remind the user what records to keep. These are practical
/// defaults, not tax advice — the user adjusts per their situation.
class ExpenseCategory {
  const ExpenseCategory({
    required this.code,
    required this.account,
    required this.label,
    this.defaultBusinessUsePercent = 100,
    this.deductibleByDefault = true,
    this.suggestsProration = false,
    this.hint = const {},
  });

  /// Stable key stored on the expense row.
  final String code;

  /// Japanese account heading (勘定科目) printed on JP reports.
  final String account;

  /// Trilingual display label (en/nl/ja). Falls back to en.
  final Map<String, String> label;

  final int defaultBusinessUsePercent;
  final bool deductibleByDefault;

  /// Whether this category typically needs a home-use split (rent, utilities…).
  final bool suggestsProration;

  /// Trilingual practical hint (en/nl/ja). Falls back to en.
  final Map<String, String> hint;

  String labelFor(String lang) => label[lang] ?? label['en'] ?? code;
  String hintFor(String lang) => hint[lang] ?? hint['en'] ?? '';
}

const expenseCategories = <ExpenseCategory>[
  ExpenseCategory(
    code: 'supplies',
    account: '消耗品費',
    label: {'en': 'Supplies', 'nl': 'Verbruiksgoederen', 'ja': '消耗品費'},
    hint: {
      'en': 'Items under ¥100,000 consumed within a year (stationery, cables, small gear).',
      'ja': '取得価額10万円未満・使用可能期間1年未満のもの。',
    },
  ),
  ExpenseCategory(
    code: 'software',
    account: '通信費',
    label: {'en': 'Software / SaaS', 'nl': 'Software / SaaS', 'ja': 'ソフトウェア（通信費）'},
    hint: {
      'en': 'Subscriptions and licences used for the business (IDE, hosting, design tools).',
      'ja': '事業で使うサブスク・ライセンス。',
    },
  ),
  ExpenseCategory(
    code: 'communication',
    account: '通信費',
    label: {'en': 'Communication', 'nl': 'Communicatie', 'ja': '通信費'},
    defaultBusinessUsePercent: 70,
    suggestsProration: true,
    hint: {
      'en': 'Internet / mobile. Apportion if the line is shared with personal use.',
      'ja': '通信費。私用と共用なら家事按分。',
    },
  ),
  ExpenseCategory(
    code: 'travel',
    account: '旅費交通費',
    label: {'en': 'Travel & transport', 'nl': 'Reiskosten', 'ja': '旅費交通費'},
    hint: {
      'en': 'Trains, flights, hotels for business. Keep the itinerary/purpose.',
      'ja': '交通費・宿泊費。行程と目的を記録。',
    },
  ),
  ExpenseCategory(
    code: 'entertainment',
    account: '接待交際費',
    label: {'en': 'Entertainment', 'nl': 'Representatie', 'ja': '接待交際費'},
    hint: {
      'en': 'Client meals/gifts. Record who, and the business reason.',
      'ja': '接待・贈答。相手先と目的を必ず記録。',
    },
  ),
  ExpenseCategory(
    code: 'meeting',
    account: '会議費',
    label: {'en': 'Meetings', 'nl': 'Vergaderkosten', 'ja': '会議費'},
    hint: {
      'en': 'Coffee/lunch during business meetings (modest amounts).',
      'ja': '打合せの飲食（少額）。',
    },
  ),
  ExpenseCategory(
    code: 'rent',
    account: '地代家賃',
    label: {'en': 'Rent (home office)', 'nl': 'Huur (thuiskantoor)', 'ja': '地代家賃'},
    defaultBusinessUsePercent: 30,
    suggestsProration: true,
    hint: {
      'en': 'Home-office share of rent by floor area or time (家事按分).',
      'ja': '家賃のうち事業使用分を床面積等で按分。',
    },
  ),
  ExpenseCategory(
    code: 'utilities',
    account: '水道光熱費',
    label: {'en': 'Utilities', 'nl': 'Nutsvoorzieningen', 'ja': '水道光熱費'},
    defaultBusinessUsePercent: 30,
    suggestsProration: true,
    hint: {
      'en': 'Electricity/gas/water — business share only (家事按分).',
      'ja': '電気・ガス・水道の事業使用分のみ。',
    },
  ),
  ExpenseCategory(
    code: 'books',
    account: '新聞図書費',
    label: {'en': 'Books & references', 'nl': 'Vakliteratuur', 'ja': '新聞図書費'},
    hint: {
      'en': 'Technical books, courses, reference material.',
      'ja': '専門書・資料・購読。',
    },
  ),
  ExpenseCategory(
    code: 'advertising',
    account: '広告宣伝費',
    label: {'en': 'Advertising', 'nl': 'Reclamekosten', 'ja': '広告宣伝費'},
    hint: {'en': 'Ads, portfolio site, business cards.', 'ja': '広告・名刺・サイト。'},
  ),
  ExpenseCategory(
    code: 'outsourcing',
    account: '外注工賃',
    label: {'en': 'Outsourcing', 'nl': 'Uitbesteding', 'ja': '外注工賃'},
    hint: {
      'en': 'Work subcontracted to others. Keep invoices.',
      'ja': '外注先への支払。請求書を保管。',
    },
  ),
  ExpenseCategory(
    code: 'fees',
    account: '支払手数料',
    label: {'en': 'Fees & commissions', 'nl': 'Kosten & commissies', 'ja': '支払手数料'},
    hint: {
      'en': 'Bank charges, platform/payment fees, accountant fees.',
      'ja': '銀行手数料・決済手数料・税理士報酬など。',
    },
  ),
  ExpenseCategory(
    code: 'depreciation',
    account: '減価償却費',
    label: {'en': 'Depreciation', 'nl': 'Afschrijving', 'ja': '減価償却費'},
    hint: {
      'en': 'Assets ≥ ¥100,000 are depreciated over their useful life, not expensed at once.',
      'ja': '10万円以上の資産は耐用年数で減価償却。',
    },
  ),
  ExpenseCategory(
    code: 'taxes',
    account: '租税公課',
    label: {'en': 'Taxes & dues', 'nl': 'Belastingen & heffingen', 'ja': '租税公課'},
    hint: {
      'en': 'Business taxes/levies (e.g. 個人事業税). NOT income tax or residents\' tax.',
      'ja': '事業税・印紙税など。所得税・住民税は対象外。',
    },
  ),
  ExpenseCategory(
    code: 'misc',
    account: '雑費',
    label: {'en': 'Miscellaneous', 'nl': 'Overige', 'ja': '雑費'},
    hint: {'en': 'Small business costs that fit no other heading.', 'ja': '他に当てはまらない少額の経費。'},
  ),
];

ExpenseCategory expenseCategoryByCode(String code) =>
    expenseCategories.firstWhere((c) => c.code == code,
        orElse: () => expenseCategories.last);

/// Deductible amount in minor units after the deductible flag and home-use
/// apportionment are applied.
int deductibleMinorOf({
  required bool deductible,
  required int amountMinor,
  required int businessUsePercent,
}) =>
    deductible ? (amountMinor * businessUsePercent / 100).round() : 0;
