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

  group('Inventory Multi-Term Search & Physical Actions Tests', () {
    final now = DateTime.now();

    setUp(() async {
      // Setup hierarchy
      final loc = Location(
          id: 'loc_garage',
          workspaceId: 'ws_1',
          name: 'Garage',
          createdAt: now,
          updatedAt: now);
      await locationRepo.saveLocation(loc);

      final bin1 = Bin(
          id: 'bin_b17',
          workspaceId: 'ws_1',
          locationId: 'loc_garage',
          code: 'B17',
          createdAt: now,
          updatedAt: now);
      final bin2 = Bin(
          id: 'bin_a01',
          workspaceId: 'ws_1',
          locationId: 'loc_garage',
          code: 'A01',
          createdAt: now,
          updatedAt: now);
      await binRepo.saveBin(bin1);
      await binRepo.saveBin(bin2);

      // Seed items
      final item1 = Item(
        id: 'i1',
        workspaceId: 'ws_1',
        sku: 'SKU-001',
        title: 'Nike Red Jacket',
        brand: 'Nike',
        color: 'Red',
        size: 'XL',
        status: ItemStatus.stored,
        locationId: 'loc_garage',
        binId: 'bin_b17',
        cost: Money.fromMajorUnits(15.00, 'USD'),
        createdAt: now,
        updatedAt: now,
      );

      final item2 = Item(
        id: 'i2',
        workspaceId: 'ws_1',
        sku: 'SKU-002',
        title: 'Untitled item', // Incomplete item from Turbo Intake
        status: ItemStatus.stored,
        locationId: 'loc_garage',
        binId: 'bin_a01',
        createdAt: now,
        updatedAt: now,
      );

      final item3 = Item(
        id: 'i3',
        workspaceId: 'ws_1',
        sku: 'SKU-003',
        title: 'Adidas Vintage Shorts',
        brand: 'Adidas',
        status: ItemStatus.sold,
        locationId: 'loc_garage',
        binId: 'bin_b17',
        createdAt: now,
        updatedAt: now,
      );

      await itemRepo.saveItem(item1);
      await itemRepo.saveItem(item2);
      await itemRepo.saveItem(item3);
    });

    test('multi-term search matches title, brand, size, color', () async {
      final results = await itemRepo.searchItems('ws_1', 'nike red xl');
      expect(results.length, 1);
      expect(results.first.id, 'i1');
    });

    test('bin code search matches joined Bin.code', () async {
      final results = await itemRepo.searchItems('ws_1', 'B17');
      expect(results.length, 2); // i1 and i3 are in B17
    });

    test('status filter narrows search results', () async {
      final soldItems =
          await itemRepo.searchItems('ws_1', '', statusFilter: ItemStatus.sold);
      expect(soldItems.length, 1);
      expect(soldItems.first.id, 'i3');
    });

    test('Needs Details filter locates incomplete items', () async {
      final incompleteItems =
          await itemRepo.searchItems('ws_1', '', needsDetailsOnly: true);
      expect(incompleteItems.length, 1);
      expect(incompleteItems.first.id, 'i2');
      expect(incompleteItems.first.title, 'Untitled item');
    });

    test('physical action MARK SOLD updates item status', () async {
      final item = await itemRepo.getItem('i1');
      expect(item?.status, ItemStatus.stored);

      final updated = item!.copyWith(status: ItemStatus.sold);
      await itemRepo.saveItem(updated);

      final reFetched = await itemRepo.getItem('i1');
      expect(reFetched?.status, ItemStatus.sold);
    });

    test('progressive enrichment updates metadata', () async {
      final item = await itemRepo.getItem('i2');
      final enriched = item!.copyWith(
        title: 'Puma Running Shoes',
        brand: 'Puma',
        category: 'Footwear',
        size: '10.5',
      );

      await itemRepo.saveItem(enriched);

      // Verify item no longer appears in Needs Details filter
      final incompleteAfterEnrichment =
          await itemRepo.searchItems('ws_1', '', needsDetailsOnly: true);
      expect(incompleteAfterEnrichment, isEmpty);
    });
  });
}
