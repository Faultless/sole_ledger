import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/features/expenses/receipt_parser.dart';

void main() {
  group('parseReceiptText — Dutch receipt', () {
    final r = parseReceiptText('''
Albert Heijn
Datum: 14-03-2026
Broodje        € 2,50
Koffie         € 3,00
Subtotaal      € 5,50
BTW 9%         € 0,50
Totaal         € 6,00
''');

    test('reads the total, not the subtotal', () {
      expect(r.amountMajor, 6.00);
    });
    test('reads the VAT amount and rate', () {
      expect(r.vatMajor, 0.50);
      expect(r.vatRate, 9);
    });
    test('reads the date (dd-mm-yyyy)', () {
      expect(r.date, DateTime(2026, 3, 14));
    });
    test('detects EUR from the € symbol', () {
      expect(r.currency, 'EUR');
    });
  });

  group('parseReceiptText — Japanese receipt', () {
    final r = parseReceiptText('''
セブンイレブン
2026年03月14日
おにぎり        150
お茶            130
小計            280
消費税(8%)       22
合計          ¥302
お預り          500
お釣り          198
''');

    test('reads 合計 as the total, ignoring 小計/お預り/お釣り', () {
      expect(r.amountMajor, 302);
    });
    test('reads 消費税 amount and 8% rate', () {
      expect(r.vatMajor, 22);
      expect(r.vatRate, 8);
    });
    test('reads the Japanese date', () {
      expect(r.date, DateTime(2026, 3, 14));
    });
    test('detects JPY from ¥ and treats grouping as thousands', () {
      expect(r.currency, 'JPY');
    });
  });

  group('empty / unreadable input', () {
    test('returns an empty result', () {
      expect(parseReceiptText('   \n  ').isEmpty, isTrue);
    });
  });
}
