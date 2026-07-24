import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

// ---------------------------------------------------------------------------
// Tables
//
// Money is stored as integer minor units (see core/money). Enum-ish fields are
// stored as their Dart `.name` string so the schema stays readable and stable
// even as we add treatments. Foreign keys use text UUIDs generated app-side so
// records can be created offline and later synced without id collisions.
// ---------------------------------------------------------------------------

/// The user's own business. Expected to hold a single row.
class BusinessProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get legalName => text().withDefault(const Constant(''))();
  TextColumn get tradeName => text().withDefault(const Constant(''))();
  TextColumn get kvkNumber => text().withDefault(const Constant(''))();
  TextColumn get vatId => text().withDefault(const Constant(''))(); // NL BTW-id
  TextColumn get jpBusinessNumber =>
      text().withDefault(const Constant(''))(); // 適格請求書 registration no.
  TextColumn get addressLine1 => text().withDefault(const Constant(''))();
  TextColumn get addressLine2 => text().withDefault(const Constant(''))();
  TextColumn get postalCode => text().withDefault(const Constant(''))();
  TextColumn get city => text().withDefault(const Constant(''))();
  TextColumn get country => text().withDefault(const Constant('Japan'))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get iban => text().withDefault(const Constant(''))();
  TextColumn get bic => text().withDefault(const Constant(''))();
  TextColumn get bankName => text().withDefault(const Constant(''))();
  TextColumn get defaultCurrency => text().withDefault(const Constant('EUR'))();
  TextColumn get defaultLanguage => text().withDefault(const Constant('en'))();
  TextColumn get invoiceNumberPrefix =>
      text().withDefault(const Constant('INV'))();
  IntColumn get nextInvoiceSeq => integer().withDefault(const Constant(1))();
  TextColumn get logoPath => text().nullable()();
  TextColumn get signaturePath => text().nullable()();
  RealColumn get defaultHourlyRate =>
      real().withDefault(const Constant(0))(); // major units of defaultCurrency

  @override
  Set<Column> get primaryKey => {id};
}

class Clients extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get contactName => text().withDefault(const Constant(''))();
  TextColumn get vatId => text().withDefault(const Constant(''))();
  TextColumn get addressLine1 => text().withDefault(const Constant(''))();
  TextColumn get addressLine2 => text().withDefault(const Constant(''))();
  TextColumn get postalCode => text().withDefault(const Constant(''))();
  TextColumn get city => text().withDefault(const Constant(''))();
  TextColumn get country => text().withDefault(const Constant('Netherlands'))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get defaultCurrency => text().withDefault(const Constant('EUR'))();
  /// Preferred language for invoices/reports sent to this client.
  TextColumn get language => text().withDefault(const Constant('nl'))();
  /// Default VAT treatment name (see VatTreatment enum).
  TextColumn get defaultVatTreatment =>
      text().withDefault(const Constant('reverseChargeEu'))();
  RealColumn get defaultHourlyRate => real().nullable()();
  IntColumn get paymentTermDays => integer().withDefault(const Constant(30))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(Clients, #id)();
  TextColumn get name => text()();
  RealColumn get hourlyRate => real().nullable()(); // overrides client rate
  TextColumn get currency => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class TimeEntries extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(Clients, #id)();
  TextColumn get projectId => text().nullable().references(Projects, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get minutes => integer()();
  TextColumn get description => text().withDefault(const Constant(''))();
  BoolColumn get billable => boolean().withDefault(const Constant(true))();
  TextColumn get rounding => text().withDefault(const Constant('none'))();
  /// Set once this entry has been placed on an invoice.
  TextColumn get invoiceId => text().nullable().references(Invoices, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class Expenses extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get category => text().withDefault(const Constant('general'))();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get amountMinor => integer()();
  IntColumn get vatMinor => integer().withDefault(const Constant(0))();
  TextColumn get currency => text().withDefault(const Constant('JPY'))();
  BoolColumn get deductible => boolean().withDefault(const Constant(true))();
  /// Business-use percentage for 家事按分 (home/personal apportionment).
  /// 100 = fully business. Deductible amount = amountMinor * pct / 100.
  IntColumn get businessUsePercent =>
      integer().withDefault(const Constant(100))();
  TextColumn get receiptPath => text().nullable()();
  /// Attached receipt image bytes (compressed JPEG/PNG). Stored in-DB so the
  /// whole ledger stays a single portable file and works identically on web
  /// (OPFS) and Android — see receipt_image.dart for the capture/compress path.
  BlobColumn get receiptImage => blob().nullable()();
  TextColumn get receiptMime => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Invoices extends Table {
  TextColumn get id => text()();
  TextColumn get number => text()();
  TextColumn get clientId => text().references(Clients, #id)();
  DateTimeColumn get issueDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get currency => text().withDefault(const Constant('EUR'))();
  TextColumn get language => text().withDefault(const Constant('nl'))();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get purchaseOrder => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  IntColumn get subtotalMinor => integer().withDefault(const Constant(0))();
  IntColumn get taxMinor => integer().withDefault(const Constant(0))();
  IntColumn get totalMinor => integer().withDefault(const Constant(0))();
  DateTimeColumn get paidDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class InvoiceLines extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text().references(Invoices, #id)();
  TextColumn get description => text()();
  RealColumn get quantity => real().withDefault(const Constant(1))();
  TextColumn get unit => text().withDefault(const Constant('hours'))();
  IntColumn get unitPriceMinor => integer()();
  TextColumn get vatTreatment =>
      text().withDefault(const Constant('reverseChargeEu'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    BusinessProfiles,
    Clients,
    Projects,
    TimeEntries,
    Expenses,
    Invoices,
    InvoiceLines,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  /// Opens the platform-appropriate database. On native platforms Drift uses
  /// a file in the app documents dir; on web it uses the sqlite3 WASM build and
  /// the drift worker, both shipped from `web/` (see README for provenance).
  static QueryExecutor _openConnection() => driftDatabase(
        name: 'sole_ledger',
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.js'),
        ),
      );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(expenses, expenses.businessUsePercent);
          }
          if (from < 3) {
            await m.addColumn(expenses, expenses.receiptImage);
            await m.addColumn(expenses, expenses.receiptMime);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          // Self-heal: some on-device databases (particularly the web build's
          // persisted store) can end up with a version number that skips a
          // migration, leaving a newer column missing. Add any such column
          // idempotently so writes never fail on a stale local database.
          await _ensureColumn(
            table: 'expenses',
            column: 'business_use_percent',
            definition: 'INTEGER NOT NULL DEFAULT 100',
          );
          await _ensureColumn(
            table: 'expenses',
            column: 'receipt_image',
            definition: 'BLOB',
          );
          await _ensureColumn(
            table: 'expenses',
            column: 'receipt_mime',
            definition: 'TEXT',
          );
        },
      );

  /// Adds [column] to [table] if it does not already exist. Safe to call on
  /// every open.
  Future<void> _ensureColumn({
    required String table,
    required String column,
    required String definition,
  }) async {
    final info = await customSelect("PRAGMA table_info('$table')").get();
    final existing = info.map((row) => row.data['name'] as String?).toSet();
    if (!existing.contains(column)) {
      await customStatement('ALTER TABLE "$table" ADD COLUMN "$column" $definition');
    }
  }
}
