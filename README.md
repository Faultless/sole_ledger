# Sole Ledger

Bookkeeping for a **Dutch eenmanszaak (KvK-registered) whose owner is tax-resident in Japan**,
invoicing Dutch/EU business clients. Flutter, targeting **web + Android** first (iOS/macOS also build).

> ⚠️ **Not tax advice.** Every tax figure in this app is an *estimate* to help you plan and prepare
> filings. Confirm your VAT treatment and income-tax position with your boekhouder / 税理士.

## The tax model (why it works the way it does)

Income tax and VAT/consumption tax are **separate regimes**:

- **Income tax** — You are tax-resident in Japan, so Japan taxes your worldwide income via
  確定申告 (kakutei shinkoku). The NL–Japan treaty prevents double taxation.
- **VAT / consumption tax** — A *transaction* tax decided by where the supply happens and where the
  business is *established*, **not** by income-tax residency. For services performed from Japan for a
  Dutch business client, the usual outcome is:
  - **Japanese 消費税:** export of services → zero-rated (輸出免税); no 10% added.
  - **Dutch BTW:** reverse-charged; invoice at **0% with a "VAT reverse-charged / BTW verlegd" note**,
    the client self-accounts.

Because the exact answer depends on facts (active NL VAT registration? registered 課税事業者?
turnover thresholds?), VAT treatment is a **per-client / per-invoice setting** with correct legal
wording in EN/NL/JA for each case. Default: `reverseChargeEu`. See
`lib/domain/tax/vat_treatment.dart`.

## Architecture

Feature-first, offline-first (local SQLite via Drift). No backend in v1.

```
lib/
  core/        money (integer minor units), formatters, theme, router, shared widgets
  domain/      pure, tested business logic — VAT engine, invoice totals, JP income-tax estimator
  data/        Drift schema + generated code, repository, Riverpod providers
  features/    dashboard · time · clients · invoices · reports · settings · shell
  l10n/        app_en/nl/ja.arb  →  generated L10n
```

- **State:** Riverpod 3 · **Nav:** go_router (responsive rail/bottom-bar shell)
- **DB:** Drift (`dart run build_runner build` after schema changes)
- **i18n:** `flutter gen-l10n` (runs on build; `generate: true` in pubspec)
- **Money:** never `double`. `Money` holds integer minor units + currency; tax rounds once per rate group.

## Status

| Area | State |
|------|-------|
| Money + VAT engine + JP income-tax estimator | ✅ done, unit-tested (`test/tax_test.dart`) |
| Local DB, repository, providers | ✅ done, integration-tested (`test/repository_test.dart`) |
| Tri-lingual i18n (EN/NL/JA) with legal wording | ✅ done |
| Dashboard, Time tracking, Clients, Settings | ✅ functional |
| Invoice builder (pull unbilled time → lines → VAT) | ✅ done |
| Invoice PDF (tri-lingual, CJK, reverse-charge note, signature) | ✅ done |
| Timesheet (PDF + Markdown), Quarterly VAT (PDF), Annual income + JP tax estimate (PDF) | ✅ done |
| Expenses (entry, categories, VAT auto-split, deductible YTD) | ✅ done |
| Projects per client (client detail screen, wired into time + invoices) | ✅ done |
| Deductible helpers: JP 勘定科目 categories, 家事按分 proration, deductibility hints | ✅ done |

The business trade name defaults to **Frontendienst** (seeded in the first business-profile row).
Expenses schema is at **v2** (added `businessUsePercent` for 家事按分; migration in `AppDatabase`).

### Possible next steps
- Runtime smoke-test on web (Google-Fonts fetch + Drift WASM needs COOP/COEP headers when served) and on an Android device.
- Multi-currency FX handling beyond the single EUR→JPY rate used in the annual report.
- Signature image capture and business logo upload (fields exist in the schema).
- Receipt image attachment for expenses (`receiptPath` column exists, no picker yet).
- Depreciation schedule for assets ≥ ¥100,000 (currently a single-line expense + hint).

## Web runtime assets

`web/sqlite3.wasm` and `web/drift_worker.js` are required for Drift on the web and are **downloaded
artifacts**, not source. Provenance (keep in sync with `pubspec.lock`):

- `sqlite3.wasm` — from `simolus3/sqlite3.dart` release `sqlite3-3.5.0`
- `drift_worker.js` — from `simolus3/drift` release `drift-2.34.2`

Re-fetch these to matching versions whenever `drift` / `sqlite3` are upgraded.

## Run

```bash
flutter pub get
dart run build_runner build      # regenerate Drift/l10n if schema or ARB changed
flutter run -d chrome            # or: flutter run -d <android-device>
flutter test
```
