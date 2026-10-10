import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/enums.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/money.dart';
import 'package:reseller_inventory_app/features/workspace/domain/workspace.dart';
import 'package:reseller_inventory_app/features/workspace/domain/location.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item_photo.dart';
import 'package:reseller_inventory_app/features/inventory/domain/inventory_event.dart';
import 'package:reseller_inventory_app/features/workspace/data/workspace_repository_impl.dart';
import 'package:reseller_inventory_app/features/workspace/data/location_repository_impl.dart';
import 'package:reseller_inventory_app/features/bins/data/bin_repository_impl.dart';
import 'package:reseller_inventory_app/features/inventory/data/item_repository_impl.dart';
import 'package:reseller_inventory_app/features/inventory/data/inventory_repository_impl.dart';

void main() {
  late AppDatabase db;
  late WorkspaceRepositoryImpl workspaceRepo;
  late LocationRepositoryImpl locationRepo;
  late BinRepositoryImpl binRepo;
  late ItemRepositoryImpl itemRepo;
  late InventoryRepositoryImpl inventoryRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    workspaceRepo = WorkspaceRepositoryImpl(db);
    locationRepo = LocationRepositoryImpl(db);
    binRepo = BinRepositoryImpl(db);
    itemRepo = ItemRepositoryImpl(db);
    inventoryRepo = InventoryRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Repository Pattern End-to-End Tests', () {
    final now = DateTime.now();

    test('Full lifecycle: Workspace, Location, Bin, Item, Photos, Events',
        () async {
      // 1. Workspace
      final ws = Workspace(
          id: 'ws_1', name: 'Main Store', createdAt: now, updatedAt: now);
      await workspaceRepo.saveWorkspace(ws);
      final fetchedWs = await workspaceRepo.getWorkspace('ws_1');
      expect(fetchedWs?.name, 'Main Store');

      // 2. Location
      final loc = Location(
          id: 'loc_1',
          workspaceId: 'ws_1',
          name: 'Warehouse',
          createdAt: now,
          updatedAt: now);
      await locationRepo.saveLocation(loc);
      final locations = await locationRepo.getLocationsForWorkspace('ws_1');
      expect(locations.length, 1);

      // 3. Bin
      final bin = Bin(
          id: 'bin_1',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'B01',
          createdAt: now,
          updatedAt: now);
      await binRepo.saveBin(bin);
      final fetchedBin = await binRepo.getBinByCode('loc_1', 'B01');
      expect(fetchedBin?.id, 'bin_1');

      // 4. Item
      final item = Item(
        id: 'item_1',
        workspaceId: 'ws_1',
        sku: 'SKU-2002',
        title: 'Sony Vintage Walkman',
        status: ItemStatus.stored,
        locationId: 'loc_1',
        binId: 'bin_1',
        cost: Money.fromMajorUnits(25.00, 'USD'),
        createdAt: now,
        updatedAt: now,
      );
      await itemRepo.saveItem(item);

      final fetchedItem = await itemRepo.getItemBySku('ws_1', 'SKU-2002');
      expect(fetchedItem?.title, 'Sony Vintage Walkman');

      // 5. Item Photos
      final photo = ItemPhoto(
          id: 'photo_1',
          itemId: 'item_1',
          localPath: '/img1.png',
          createdAt: now);
      await itemRepo.saveItemPhoto(photo);
      final photos = await itemRepo.getPhotosForItem('item_1');
      expect(photos.length, 1);

      // 6. Inventory Event
      final event = InventoryEvent(
        id: 'evt_1',
        workspaceId: 'ws_1',
        itemId: 'item_1',
        type: InventoryEventType.itemCreated,
        toLocationId: 'loc_1',
        toBinId: 'bin_1',
        occurredAt: now,
      );
      await inventoryRepo.recordEvent(event);
      final events = await inventoryRepo.getEventsForItem('item_1');
      expect(events.length, 1);
      expect(events.first.type, InventoryEventType.itemCreated);

      // 7. Search
      final searchResults = await itemRepo.searchItems('ws_1', 'Walkman');
      expect(searchResults.length, 1);
      expect(searchResults.first.id, 'item_1');
    });
  });
}
