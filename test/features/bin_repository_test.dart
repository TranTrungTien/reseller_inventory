import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/features/bins/data/bin_repository_impl.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';
import 'package:reseller_inventory_app/features/inventory/data/item_repository_impl.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item.dart';

void main() {
  late AppDatabase db;
  late BinRepositoryImpl binRepo;
  late ItemRepositoryImpl itemRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    binRepo = BinRepositoryImpl(db);
    itemRepo = ItemRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Bin Repository Advanced Tests', () {
    final now = DateTime.now();

    test('prevents duplicate active bin codes in same location', () async {
      final bin1 = Bin(
        id: 'bin_1',
        workspaceId: 'ws_1',
        locationId: 'loc_garage',
        code: 'A01',
        createdAt: now,
        updatedAt: now,
      );
      await binRepo.saveBin(bin1);

      // Check if A01 is available in garage -> should be false
      final isAvailable = await binRepo.isBinCodeAvailable('loc_garage', 'A01');
      expect(isAvailable, isFalse);

      // Same code in DIFFERENT location -> should be true
      final isAvailableDifferentLoc =
          await binRepo.isBinCodeAvailable('loc_basement', 'A01');
      expect(isAvailableDifferentLoc, isTrue);

      // Excluding current bin ID when editing -> should be true
      final isAvailableSelf = await binRepo
          .isBinCodeAvailable('loc_garage', 'A01', excludeBinId: 'bin_1');
      expect(isAvailableSelf, isTrue);
    });

    test('calculates item count for bin correctly', () async {
      final bin = Bin(
          id: 'bin_100',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'B01',
          createdAt: now,
          updatedAt: now);
      await binRepo.saveBin(bin);

      expect(await binRepo.getItemCountForBin('bin_100'), 0);

      final item1 = Item(
          id: 'i1',
          workspaceId: 'ws_1',
          sku: 'S1',
          title: 'T1',
          binId: 'bin_100',
          createdAt: now,
          updatedAt: now);
      final item2 = Item(
          id: 'i2',
          workspaceId: 'ws_1',
          sku: 'S2',
          title: 'T2',
          binId: 'bin_100',
          createdAt: now,
          updatedAt: now);

      await itemRepo.saveItem(item1);
      await itemRepo.saveItem(item2);

      expect(await binRepo.getItemCountForBin('bin_100'), 2);
    });

    test('bin search and archiving', () async {
      final bin1 = Bin(
          id: 'b1',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'ALPHA',
          description: 'Top shelf',
          createdAt: now,
          updatedAt: now);
      final bin2 = Bin(
          id: 'b2',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'BETA',
          description: 'Bottom shelf',
          createdAt: now,
          updatedAt: now);

      await binRepo.saveBin(bin1);
      await binRepo.saveBin(bin2);

      final searchResult = await binRepo.searchBins('ws_1', 'top');
      expect(searchResult.length, 1);
      expect(searchResult.first.code, 'ALPHA');

      // Archive b1
      await binRepo.archiveBin('b1');

      final activeBins = await binRepo.getBinsForWorkspace('ws_1');
      expect(activeBins.length, 1);
      expect(activeBins.first.code, 'BETA');

      final allBinsWithArchived =
          await binRepo.getBinsForWorkspace('ws_1', includeArchived: true);
      expect(allBinsWithArchived.length, 2);
    });
  });
}
