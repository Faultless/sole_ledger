// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Sole Ledger';

  @override
  String get navDashboard => 'ダッシュボード';

  @override
  String get navTime => '稼働時間';

  @override
  String get navClients => '取引先';

  @override
  String get navInvoices => '請求書';

  @override
  String get navReports => 'レポート';

  @override
  String get navExpenses => '経費';

  @override
  String get navAssets => '固定資産';

  @override
  String get navSettings => '設定';

  @override
  String get expenseCategory => '勘定科目';

  @override
  String get expenseDeductible => '控除対象';

  @override
  String get expenseVatAmount => '支払消費税';

  @override
  String get expenseAmount => '金額';

  @override
  String get receiptTitle => 'レシート';

  @override
  String get receiptScan => 'スキャン';

  @override
  String get receiptAttach => '添付';

  @override
  String get receiptRemove => 'レシートを削除';

  @override
  String get receiptScanning => 'レシートを読み取り中…';

  @override
  String get receiptFromScanVerify => 'スキャンから入力しました — 各項目をご確認ください';

  @override
  String get receiptScanNothing => '値を読み取れませんでした — 手動で入力してください';

  @override
  String get projectsTitle => 'プロジェクト';

  @override
  String get projectName => 'プロジェクト名';

  @override
  String get projectRate => '時間単価（任意）';

  @override
  String get projectActive => '有効';

  @override
  String get clientDetails => '取引先情報';

  @override
  String get commonSave => '保存';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonDelete => '削除';

  @override
  String get commonEdit => '編集';

  @override
  String get commonAdd => '追加';

  @override
  String get commonClose => '閉じる';

  @override
  String get commonExport => 'エクスポート';

  @override
  String get commonExportPdf => 'PDFで出力';

  @override
  String get commonExportMarkdown => 'Markdownで出力';

  @override
  String get commonNet => '小計（税抜）';

  @override
  String get commonTax => '消費税';

  @override
  String get commonTotal => '合計';

  @override
  String get commonHours => '時間';

  @override
  String get commonCurrency => '通貨';

  @override
  String get commonRevenue => '売上（税抜）';

  @override
  String get commonExpenses => '経費';

  @override
  String get commonResult => '損益';

  @override
  String get commonEmpty => 'まだ登録がありません';

  @override
  String get commonSelect => '選択';

  @override
  String get commonSelectAll => 'すべて選択';

  @override
  String get commonClearSelection => '選択を解除';

  @override
  String commonSelectedCount(int count) {
    return '$count件選択中';
  }

  @override
  String commonDeleteCountConfirm(int count) {
    return '$count件を削除しますか?元に戻せません。';
  }

  @override
  String get commonToday => '今日';

  @override
  String get commonRefresh => '更新';

  @override
  String get dashboardHoursThisMonth => '今月の稼働時間';

  @override
  String get dashboardUnbilled => '未請求';

  @override
  String get dashboardOutstanding => '未回収の請求書';

  @override
  String get dashboardQuarterTax => '四半期の納税準備額（概算）';

  @override
  String get dashboardWelcome => 'おかえりなさい';

  @override
  String get dashboardQuickTime => '稼働時間を記録';

  @override
  String get dashboardQuickInvoice => '新規請求書';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSystem => 'システムの既定';

  @override
  String get settingsBusinessProfile => '事業者情報';

  @override
  String get settingsBusinessProfileSubtitle => '名称、KvK、VAT番号、口座情報、署名';

  @override
  String get settingsTaxDisclaimerTitle => '税額表示について';

  @override
  String get settingsTaxDisclaimer =>
      '本アプリに表示される税額は、計画および申告準備のための概算です。税務アドバイスではありません。VATの取扱いおよび所得税の判断については、会計士（boekhouder）または税理士にご確認ください。';

  @override
  String get vatReverseChargeEuLabel => 'リバースチャージ';

  @override
  String get vatReverseChargeEuNote =>
      '本取引はEU域内のB2B役務としてリバースチャージ方式が適用され、VATは顧客側で申告・納付されます（EU指令2006/112/EC 第196条）。';

  @override
  String get vatExportExemptJpLabel => '輸出免税（役務の提供）';

  @override
  String get vatExportExemptJpNote => '本役務の提供は消費税法上の輸出免税取引に該当し、日本の消費税は課されません。';

  @override
  String get vatStandardNl21Label => 'VAT 21%（オランダ）';

  @override
  String get vatReducedNl9Label => 'VAT 9%（オランダ）';

  @override
  String get vatStandardNlNote => 'オランダ付加価値税（BTW）。';

  @override
  String get vatStandardJp10Label => '消費税 10%';

  @override
  String get vatStandardJpNote => '日本の消費税。';

  @override
  String get vatSmallBusinessLabel => '免税事業者';

  @override
  String get vatSmallBusinessNote => '当事業者は免税事業者であり、消費税は課されません。';

  @override
  String get vatNoneLabel => '課税対象外';

  @override
  String get vatNoneNote => '本取引は課税対象外です。';

  @override
  String get invoiceTitle => '請求書';

  @override
  String get invoiceNumber => '請求書番号';

  @override
  String get invoiceIssueDate => '発行日';

  @override
  String get invoiceDueDate => '支払期限';

  @override
  String get invoiceDueDateEnabled => '支払期限を設定する';

  @override
  String get invoiceBillTo => '請求先';

  @override
  String get invoiceFrom => '請求元';

  @override
  String get invoiceDescription => '内容';

  @override
  String get invoiceQuantity => '数量';

  @override
  String get invoiceUnitPrice => '単価';

  @override
  String get invoiceLineTotal => '金額';

  @override
  String get invoicePaymentDetails => 'お支払い情報';

  @override
  String invoicePaymentDue(String date) {
    return '支払期限：$date';
  }

  @override
  String get invoiceThankYou => 'お取引ありがとうございます。';

  @override
  String get invoiceSignature => '署名';

  @override
  String get invoiceSignatureClient => '署名（先方）';

  @override
  String get invoiceKvk => 'KvK番号';

  @override
  String get invoiceVatId => 'VAT番号';

  @override
  String get invoicePurchaseOrder => '発注番号';

  @override
  String get reportTimesheet => '稼働時間明細';

  @override
  String get reportQuarterlyVat => '四半期VAT集計';

  @override
  String get reportAnnualIncome => '年間損益計算書';

  @override
  String get reportPeriod => '対象期間';

  @override
  String reportGeneratedOn(String date) {
    return '作成日：$date';
  }

  @override
  String get statusDraft => '下書き';

  @override
  String get statusSent => '送付済み';

  @override
  String get statusPaid => '入金済み';

  @override
  String get statusOverdue => '期限超過';

  @override
  String get statusCancelled => '取消済み';
}
