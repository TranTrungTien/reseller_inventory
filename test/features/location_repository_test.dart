import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/features/workspace/data/location_repository_impl.dart';
import 'package:reseller_inventory_app/features/workspace/domain/location.dart';

void main() {
  late AppDatabase db;
  late LocationRepositoryImpl locationRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    locationRepo = LocationRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Location Repository Tests', () {
    final now = DateTime.now();

    test('Location CRUD and archiving', () async {
      final loc1 = Location(
          id: 'loc_1',
          workspaceId: 'ws_1',
          name: 'Garage',
          createdAt: now,
          updatedAt: now);
      final loc2 = Location(
          id: 'loc_2',
          workspaceId: 'ws_1',
          name: 'Storage Unit',
          createdAt: now,
          updatedAt: now);

      await locationRepo.saveLocation(loc1);
      await locationRepo.saveLocation(loc2);

      final activeLocs = await locationRepo.getLocationsForWorkspace('ws_1');
      expect(activeLocs.length, 2);

      // Archive loc1
      await locationRepo.archiveLocation('loc_1');

      final activeAfterArchive =
          await locationRepo.getLocationsForWorkspace('ws_1');
      expect(activeAfterArchive.length, 1);
      expect(activeAfterArchive.first.name, 'Storage Unit');

      final allLocsWithArchived = await locationRepo
          .getLocationsForWorkspace('ws_1', includeArchived: true);
      expect(allLocsWithArchived.length, 2);
    });
  });
}
