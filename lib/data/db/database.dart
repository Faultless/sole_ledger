import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'db_location.dart';

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
  /// Your handwritten signature as a transparent PNG, drawn or imported once
  /// in Settings and stamped onto invoices you choose to sign.
  ///
  /// Stored as bytes rather than reusing [signaturePath] (dead, never written)
  /// because the ledger is a single file synced between machines — a path to a
  /// local image would not survive the trip.
  BlobColumn get signatureImage => blob().nullable()();
  RealColumn get defaultHourlyRate =>
      real().withDefault(const Constant(0))(); // major units of defaultCurrency
  /// EUR→JPY rate used to convert profit for the Japanese income-tax estimate
  /// (dashboard set-aside + annual report). A planning figure, edited in Settings.
  RealColumn get eurToJpyRate =>
      real().withDefault(const Constant(160))();
  /// App theme preference: 'system' | 'light' | 'dark'.
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  /// Defaults for the contractor tax allowance applied to new invoices — the
  /// uplift covering your own tax burden. Not VAT: see ContractorAllowance.
  BoolColumn get defaultAllowanceEnabled =>
      boolean().withDefault(const Constant(true))();
  RealColumn get defaultAllowanceRatePercent =>
      real().withDefault(const Constant(25))();
  /// 'surcharge' (rate x net) or 'grossUp' (net / (1 - rate)).
  TextColumn get defaultAllowanceMode =>
      text().withDefault(const Constant('surcharge'))();

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
  /// When set (1-28), invoices fall due on that day of the month *after* the
  /// issue date, and [paymentTermDays] is ignored. Suits clients billed on a
  /// calendar-month cycle who pay on a fixed day.
  IntColumn get paymentDueDayOfMonth => integer().nullable()();
  /// Optional short form used in exported filenames, e.g. "DeliHome" for
  /// "Deli Home Netherlands B.V.". Dropping a legal suffix is a rule the app
  /// can apply; knowing which remaining words you'd drop is not, so it asks.
  TextColumn get shortName => text().nullable()();
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
  /// Whether the due date is shown at all. Off means the invoice carries no
  /// payment deadline: the header row and the "payment due by" line are left
  /// off the PDF. [dueDate] is still stored so toggling back on restores the
  /// date that was picked.
  BoolColumn get dueDateEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get currency => text().withDefault(const Constant('EUR'))();
  TextColumn get language => text().withDefault(const Constant('nl'))();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get purchaseOrder => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  IntColumn get subtotalMinor => integer().withDefault(const Constant(0))();
  IntColumn get taxMinor => integer().withDefault(const Constant(0))();
  /// The contractor tax allowance charged, as settled when the invoice was
  /// saved. Stored rather than recomputed so an issued invoice stays the
  /// document the client received, even if the default rate later changes.
  ///
  /// Defaults to off with a zero amount, which is what every invoice written
  /// before this feature carries — their totals are untouched.
  /// Whether your saved signature is stamped on this invoice. Off for every
  /// invoice written before signing existed — they were issued unsigned and
  /// stay that way until you say otherwise.
  BoolColumn get signed => boolean().withDefault(const Constant(false))();
  BoolColumn get allowanceEnabled =>
      boolean().withDefault(const Constant(false))();
  RealColumn get allowanceRatePercent =>
      real().withDefault(const Constant(0))();
  TextColumn get allowanceMode =>
      text().withDefault(const Constant('surcharge'))();
  IntColumn get allowanceMinor => integer().withDefault(const Constant(0))();
  IntColumn get totalMinor => integer().withDefault(const Constant(0))();
  DateTimeColumn get paidDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Revenue recognised from an invoice: the fee lines plus the contractor tax
/// allowance. The allowance is part of the agreed fee and is taxed as income
/// like the rest of it — leaving it out would understate revenue and, with it,
/// the tax you set aside. VAT is excluded: it is collected for the state and
/// was never yours.
extension InvoiceRevenue on Invoice {
  int get revenueMinor => subtotalMinor + allowanceMinor;
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
  /// Whether this line was generated from pulled time entries rather than
  /// typed in by hand — lets the editor's "refresh" regenerate time-tracked
  /// lines from current data while leaving manual lines untouched.
  BoolColumn get fromTimeEntries =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Fixed assets (固定資産) whose cost is deducted over time via depreciation
/// (減価償却), rather than expensed at once. See domain/tax/depreciation.dart.
class Assets extends Table {
  TextColumn get id => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get acquisitionDate => dateTime()();
  IntColumn get costMinor => integer()();
  TextColumn get currency => text().withDefault(const Constant('JPY'))();
  /// 'fullExpense' (少額特例), 'lumpThreeYear' (一括償却), 'straightLine' (定額法).
  TextColumn get method => text().withDefault(const Constant('straightLine'))();
  IntColumn get usefulLifeYears => integer().withDefault(const Constant(4))();
  IntColumn get businessUsePercent =>
      integer().withDefault(const Constant(100))();

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
    Assets,
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
        // On desktop this pins the DB to ~/SoleLedger so Syncthing can sync the
        // single ledger file; null on mobile keeps drift's app-documents path.
        native: DriftNativeOptions(databasePath: fixedDatabasePath()),
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.js'),
        ),
      );

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // Every step is idempotent. A ledger's schema and its recorded
          // version can legitimately drift apart: beforeOpen's self-heal adds
          // the newest columns on any open regardless of version, and a file
          // restored from a backup or synced from another device can arrive
          // with a version behind its own columns. A raw addColumn in that
          // situation throws "duplicate column", onUpgrade never finishes, the
          // version is never advanced — and the next open fails in exactly the
          // same way, forever. Adding only what is missing lets such a database
          // heal itself on the next open instead.
          if (from < 2) {
            await _addColumnIfMissing(m, expenses, expenses.businessUsePercent);
          }
          if (from < 3) {
            await _addColumnIfMissing(m, expenses, expenses.receiptImage);
            await _addColumnIfMissing(m, expenses, expenses.receiptMime);
          }
          if (from < 4) {
            await _addColumnIfMissing(
                m, businessProfiles, businessProfiles.eurToJpyRate);
          }
          if (from < 5) {
            await _ensureTable('assets', assets);
          }
          if (from < 6) {
            await _addColumnIfMissing(
                m, businessProfiles, businessProfiles.themeMode);
          }
          if (from < 7) {
            await _addColumnIfMissing(
                m, invoiceLines, invoiceLines.fromTimeEntries);
          }
          if (from < 8) {
            await _addColumnIfMissing(
                m, clients, clients.paymentDueDayOfMonth);
          }
          if (from < 9) {
            await _addColumnIfMissing(m, invoices, invoices.dueDateEnabled);
          }
          if (from < 10) {
            await _addColumnIfMissing(m, invoices, invoices.allowanceEnabled);
            await _addColumnIfMissing(
                m, invoices, invoices.allowanceRatePercent);
            await _addColumnIfMissing(m, invoices, invoices.allowanceMode);
            await _addColumnIfMissing(m, invoices, invoices.allowanceMinor);
            await _addColumnIfMissing(
                m, businessProfiles, businessProfiles.defaultAllowanceEnabled);
            await _addColumnIfMissing(m, businessProfiles,
                businessProfiles.defaultAllowanceRatePercent);
            await _addColumnIfMissing(
                m, businessProfiles, businessProfiles.defaultAllowanceMode);
          }
          if (from < 11) {
            await _addColumnIfMissing(
                m, businessProfiles, businessProfiles.signatureImage);
            await _addColumnIfMissing(m, invoices, invoices.signed);
            await _addColumnIfMissing(m, clients, clients.shortName);
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
          await _ensureColumn(
            table: 'business_profiles',
            column: 'eur_to_jpy_rate',
            definition: 'REAL NOT NULL DEFAULT 160',
          );
          await _ensureColumn(
            table: 'business_profiles',
            column: 'theme_mode',
            definition: "TEXT NOT NULL DEFAULT 'system'",
          );
          await _ensureTable('assets', assets);
          await _ensureColumn(
            table: 'invoice_lines',
            column: 'from_time_entries',
            definition: 'BOOLEAN NOT NULL DEFAULT 0',
          );
          await _ensureColumn(
            table: 'clients',
            column: 'payment_due_day_of_month',
            definition: 'INTEGER',
          );
          await _ensureColumn(
            table: 'invoices',
            column: 'due_date_enabled',
            definition: 'BOOLEAN NOT NULL DEFAULT 1',
          );
          await _ensureColumn(
            table: 'invoices',
            column: 'allowance_enabled',
            definition: 'BOOLEAN NOT NULL DEFAULT 0',
          );
          await _ensureColumn(
            table: 'invoices',
            column: 'signed',
            definition: 'BOOLEAN NOT NULL DEFAULT 0',
          );
          await _ensureColumn(
            table: 'business_profiles',
            column: 'signature_image',
            definition: 'BLOB',
          );
          await _ensureColumn(
            table: 'clients',
            column: 'short_name',
            definition: 'TEXT',
          );
          await _ensureColumn(
            table: 'invoices',
            column: 'allowance_rate_percent',
            definition: 'REAL NOT NULL DEFAULT 0',
          );
          await _ensureColumn(
            table: 'invoices',
            column: 'allowance_mode',
            definition: "TEXT NOT NULL DEFAULT 'surcharge'",
          );
          await _ensureColumn(
            table: 'invoices',
            column: 'allowance_minor',
            definition: 'INTEGER NOT NULL DEFAULT 0',
          );
          await _ensureColumn(
            table: 'business_profiles',
            column: 'default_allowance_enabled',
            definition: 'BOOLEAN NOT NULL DEFAULT 1',
          );
          await _ensureColumn(
            table: 'business_profiles',
            column: 'default_allowance_rate_percent',
            definition: 'REAL NOT NULL DEFAULT 25',
          );
          await _ensureColumn(
            table: 'business_profiles',
            column: 'default_allowance_mode',
            definition: "TEXT NOT NULL DEFAULT 'surcharge'",
          );
        },
      );

  /// Creates [table] if it does not exist (same self-heal rationale as
  /// [_ensureColumn], for a whole added table).
  Future<void> _ensureTable(String name, TableInfo table) async {
    final rows = await customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name = ?",
      variables: [Variable<String>(name)],
    ).get();
    if (rows.isEmpty) {
      await createMigrator().createTable(table);
    }
  }

  /// Adds [column] to [table] during a migration unless it is already there.
  /// See the note in [migration] for why every step has to tolerate a column
  /// that already exists.
  Future<void> _addColumnIfMissing(
      Migrator m, TableInfo table, GeneratedColumn column) async {
    if (await _hasColumn(table.actualTableName, column.name)) return;
    await m.addColumn(table, column);
  }

  Future<bool> _hasColumn(String table, String column) async {
    final info = await customSelect("PRAGMA table_info('$table')").get();
    return info.any((row) => row.data['name'] == column);
  }

  /// Adds [column] to [table] if it does not already exist. Safe to call on
  /// every open.
  Future<void> _ensureColumn({
    required String table,
    required String column,
    required String definition,
  }) async {
    if (await _hasColumn(table, column)) return;
    await customStatement(
        'ALTER TABLE "$table" ADD COLUMN "$column" $definition');
  }
}
