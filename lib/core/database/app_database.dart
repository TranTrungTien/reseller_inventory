import 'package:drift/drift.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Workspaces,
  Locations,
  Bins,
  Items,
  ItemPhotos,
  InventoryEvents,
  MarketplaceReferences,
  SyncOperations,
  Devices,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(locations, locations.deletedAt);
            await m.addColumn(bins, bins.deletedAt);
          }
          if (from < 3) {
            await m.addColumn(items, items.soldAt);
            await m.addColumn(items, items.salePriceMinorUnits);
            await m.addColumn(items, items.marketplaceOrderRef);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );
}
