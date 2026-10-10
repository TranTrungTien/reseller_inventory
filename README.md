# Binly / Reseller Inventory App

Offline-first physical inventory companion for one-of-one marketplace resellers.

## Product principle
Source -> Stow -> Find -> Pick. Marketplace-neutral. Local writes first, cloud sync later.

## Included scaffold
- Feature-first clean structure
- Riverpod-ready dependency/state boundary
- go_router shell navigation
- Drift schema starter: Item, Bin, immutable InventoryEvent/outbox concept
- Today, Inventory, Scan/Turbo Intake, Bins, More screens
- Global-ready currency/locale direction
- MVP roadmap and architecture docs

## Generate Drift code
`dart run build_runner build --delete-conflicting-outputs`

## Run
`flutter pub get`
`flutter run`

The execution environment used to generate this scaffold does not include Flutter/Dart, so generated Drift files, iOS and Android runner folders are intentionally not fabricated. Run `flutter create .` once locally, then build_runner.
