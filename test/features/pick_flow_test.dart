import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/enums.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/money.dart';
import 'package:reseller_inventory_app/features/workspace/domain/location.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item.dart';
import 'package:reseller_inventory_app/features/bins/data/bin_repository_impl.dart';
import 'package:reseller_inventory_app/features/workspace/data/location_repository_impl.dart';
import 'package:reseller_inventory_app/features/inventory/data/item_repository_impl.dart';

void main() {
  late AppDatabase db;
  late ItemRepositoryImpl itemRepo;
  late BinRepositoryImpl binRepo;
  late LocationRepositoryImpl locationRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    itemRepo = ItemRepositoryImpl(db);
    binRepo = BinRepositoryImpl(db);
    locationRepo = LocationRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Sold & Pick Mode Tests', () {
    final now = DateTime.now();

    setUp(() async {
      final locA = Location(
          id: 'loc_garage',
          workspaceId: 'ws_1',
          name: 'Garage',
          createdAt: now,
          updatedAt: now);
      final locB = Location(
          id: 'loc_basement',
          workspaceId: 'ws_1',
          name: 'Basement',
          createdAt: now,
          updatedAt: now);
      await locationRepo.saveLocation(locA);
      await locationRepo.saveLocation(locB);

      final bin1 = Bin(
          id: 'bin_b14',
          workspaceId: 'ws_1',
          locationId: 'loc_garage',
          code: 'B14',
          createdAt: now,
          updatedAt: now);
      final bin2 = Bin(
          id: 'bin_a01',
          workspaceId: 'ws_1',
          locationId: 'loc_basement',
          code: 'A01',
          createdAt: now,
          updatedAt: now);
      await binRepo.saveBin(bin1);
      await binRepo.saveBin(bin2);
    });

    test(
        'Mark Sold updates status, soldAt, salePrice, and appears in Ready to Pick',
        () async {
      final item = Item(
        id: 'i1',
        workspaceId: 'ws_1',
        sku: 'SKU-01',
        title: 'Sold Vintage Jacket',
        status: ItemStatus.stored,
        locationId: 'loc_garage',
        binId: 'bin_b14',
        createdAt: now,
        updatedAt: now,
      );
      await itemRepo.saveItem(item);

      final soldItem = item.copyWith(
        status: ItemStatus.sold,
        soldAt: now,
        salePrice: Money.fromMajorUnits(45.00, 'USD'),
        marketplaceOrderRef: 'EBAY-ORDER-99',
      );
      await itemRepo.saveItem(soldItem);

      final readyItems = await itemRepo.getReadyToPickItems('ws_1');
      expect(readyItems.length, 1);
      expect(readyItems.first.id, 'i1');
      expect(readyItems.first.salePrice?.amountInMajorUnits, 45.00);
      expect(readyItems.first.marketplaceOrderRef, 'EBAY-ORDER-99');
    });

    test('Ready to Pick sorts deterministically by Location -> Bin -> Title',
        () async {
      final itemInGarageB14 = Item(
        id: 'i_garage',
        workspaceId: 'ws_1',
        sku: 'SKU-G',
        title: 'Garage Item',
        status: ItemStatus.sold,
        locationId: 'loc_garage',
        binId: 'bin_b14',
        createdAt: now,
        updatedAt: now,
      );

      final itemInBasementA01 = Item(
        id: 'i_basement',
        workspaceId: 'ws_1',
        sku: 'SKU-B',
        title: 'Basement Item',
        status: ItemStatus.sold,
        locationId: 'loc_basement',
        binId: 'bin_a01',
        createdAt: now,
        updatedAt: now,
      );

      await itemRepo.saveItem(itemInGarageB14);
      await itemRepo.saveItem(itemInBasementA01);

      final readyItems = await itemRepo.getReadyToPickItems('ws_1');
      expect(readyItems.length, 2);

      // Basement (locB) comes before Garage (locA) alphabetically
      expect(readyItems[0].locationId, 'loc_basement');
      expect(readyItems[1].locationId, 'loc_garage');
    });

    test('Confirming pick updates status to picked and records event',
        () async {
      final item = Item(
        id: 'i_pick',
        workspaceId: 'ws_1',
        sku: 'SKU-P',
        title: 'Pick Me',
        status: ItemStatus.sold,
        locationId: 'loc_garage',
        binId: 'bin_b14',
        createdAt: now,
        updatedAt: now,
      );
      await itemRepo.saveItem(item);

      final pickedItem =
          item.copyWith(status: ItemStatus.picked, updatedAt: DateTime.now());
      await itemRepo.saveItem(pickedItem);

      final readyAfterPick = await itemRepo.getReadyToPickItems('ws_1');
      expect(readyAfterPick, isEmpty);

      final fetched = await itemRepo.getItem('i_pick');
      expect(fetched?.status, ItemStatus.picked);
    });
  });
}
