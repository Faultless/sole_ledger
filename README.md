# Sole Ledger

Offline-first bookkeeping for a one-person business — a Dutch eenmanszaak run from Japan: time
tracking, receipt-scanning expenses, tri-lingual (EN/NL/JA) invoices, fixed-asset depreciation, and a
live estimate of the Japanese tax to set aside. Flutter → **Android, macOS and web** from one codebase;
the whole ledger is a single local SQLite file.

> ⚠️ Every tax figure is an *estimate*. Confirm your VAT treatment and income-tax position with your
> boekhouder / 税理士.

## Get started

```bash
git clone https://github.com/Faultless/sole_ledger.git
cd sole_ledger
flutter pub get
dart run build_runner build      # generate Drift + gen-l10n code
flutter run                      # run on any connected device
```

## Build for your platform

```bash
flutter build apk --release      # Android
flutter build macos --release    # macOS desktop
flutter build web                # web (serve with COOP/COEP headers so the WASM DB can init)
```

- **First macOS build only:** `sudo xcodebuild -license accept && sudo xcodebuild -runFirstLaunch`.
- **Web** ships `web/sqlite3.wasm` + `web/drift_worker.js` (already committed; re-fetch to match
  `drift`/`sqlite3` when upgrading).
- **Data & sync:** the ledger lives at `~/SoleLedger/` on desktop and in app storage on mobile
  (enable a shared folder in Settings → Data & sync). Point Syncthing at that folder to sync devices —
  edit on one device at a time, since SQLite files can't be merged.

## Checks

```bash
flutter analyze
flutter test
```
