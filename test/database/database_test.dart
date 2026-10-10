import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/database/mappers.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/enums.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/money.dart';
import 'package:reseller_inventory_app/features/workspace/domain/workspace.dart';
import 'package:reseller_inventory_app/features/workspace/domain/location.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item_photo.dart';
import 'package:reseller_inventory_app/features/inventory/domain/inventory_event.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift AppDatabase Integration', () {
    final now = DateTime.now();

    test('Workspace -> Location -> Bin -> Item hierarchy persistence',
        () async {
      // 1. Create Workspace
      final ws = Workspace(
        id: 'ws_test',
        name: 'Test Workspace',
        createdAt: now,
        updatedAt: now,
      );
      await db.into(db.workspaces).insert(WorkspacesCompanion.insert(
            id: ws.id,
            name: ws.name,
            createdAt: Value(ws.createdAt),
            updatedAt: Value(ws.updatedAt),
          ));

      // 2. Create Location
      final loc = Location(
        id: 'loc_garage',
        workspaceId: ws.id,
        name: 'Garage',
        code: 'GAR',
        createdAt: now,
        updatedAt: now,
      );
      await db.into(db.locations).insert(LocationsCompanion.insert(
            id: loc.id,
            workspaceId: loc.workspaceId,
            name: loc.name,
            code: Value(loc.code),
            createdAt: Value(loc.createdAt),
            updatedAt: Value(loc.updatedAt),
          ));

      // 3. Create Bin
      final bin = Bin(
        id: 'bin_a01',
        workspaceId: ws.id,
        locationId: loc.id,
        code: 'A01',
        createdAt: now,
        updatedAt: now,
      );
      await db.into(db.bins).insert(BinsCompanion.insert(
            id: bin.id,
            workspaceId: bin.workspaceId,
            locationId: bin.locationId,
            code: bin.code,
            createdAt: Value(bin.createdAt),
            updatedAt: Value(bin.updatedAt),
          ));

      // 4. Create Item
      final item = Item(
        id: 'item_101',
        workspaceId: ws.id,
        sku: 'SKU-001',
        title: 'Levi Denim Jacket',
        status: ItemStatus.stored,
        locationId: loc.id,
        binId: bin.id,
        cost: Money.fromMajorUnits(12.50, 'USD'),
        createdAt: now,
        updatedAt: now,
      );
      await db.into(db.items).insert(ItemsCompanion.insert(
            id: item.id,
            workspaceId: item.workspaceId,
            sku: item.sku,
            title: item.title,
            status: Value(item.status.name),
            locationId: Value(item.locationId),
            binId: Value(item.binId),
            costMinorUnits: Value(item.cost?.amountInMinorUnits),
            createdAt: Value(item.createdAt),
            updatedAt: Value(item.updatedAt),
          ));

      // Query and verify
      final itemRow = await (db.select(db.items)
            ..where((t) => t.id.equals('item_101')))
          .getSingle();
      final domainItem = itemRow.toDomain();

      expect(domainItem.id, 'item_101');
      expect(domainItem.locationId, 'loc_garage');
      expect(domainItem.binId, 'bin_a01');
      expect(domainItem.cost?.amountInMinorUnits, 1250);
      expect(domainItem.cost?.amountInMajorUnits, 12.50);
    });

    test('Scoped SKU uniqueness constraint', () async {
      final ws1 =
          Workspace(id: 'ws_1', name: 'WS 1', createdAt: now, updatedAt: now);
      final ws2 =
          Workspace(id: 'ws_2', name: 'WS 2', createdAt: now, updatedAt: now);

      await db
          .into(db.workspaces)
          .insert(WorkspacesCompanion.insert(id: ws1.id, name: ws1.name));
      await db
          .into(db.workspaces)
          .insert(WorkspacesCompanion.insert(id: ws2.id, name: ws2.name));

      // Insert SKU-1 in ws1
      await db.into(db.items).insert(ItemsCompanion.insert(
            id: 'item_1',
            workspaceId: ws1.id,
            sku: 'SKU-SAME',
            title: 'Item 1',
          ));

      // Same SKU in DIFFERENT workspace should succeed
      await db.into(db.items).insert(ItemsCompanion.insert(
            id: 'item_2',
            workspaceId: ws2.id,
            sku: 'SKU-SAME',
            title: 'Item 2',
          ));

      final items = await db.select(db.items).get();
      expect(items.length, 2);
    });

    test('Multiple photos per item', () async {
      await db
          .into(db.workspaces)
          .insert(WorkspacesCompanion.insert(id: 'ws_1', name: 'WS 1'));
      await db.into(db.items).insert(ItemsCompanion.insert(
          id: 'item_1', workspaceId: 'ws_1', sku: 'SKU-1', title: 'Title'));

      final photo1 = ItemPhoto(
          id: 'p1',
          itemId: 'item_1',
          localPath: '/p1.jpg',
          position: 0,
          createdAt: now);
      final photo2 = ItemPhoto(
          id: 'p2',
          itemId: 'item_1',
          localPath: '/p2.jpg',
          position: 1,
          createdAt: now);

      await db.into(db.itemPhotos).insert(ItemPhotosCompanion.insert(
          id: photo1.id,
          itemId: photo1.itemId,
          localPath: Value(photo1.localPath),
          position: Value(photo1.position)));
      await db.into(db.itemPhotos).insert(ItemPhotosCompanion.insert(
          id: photo2.id,
          itemId: photo2.itemId,
          localPath: Value(photo2.localPath),
          position: Value(photo2.position)));

      final photos = await (db.select(db.itemPhotos)
            ..where((t) => t.itemId.equals('item_1')))
          .get();
      expect(photos.length, 2);
      expect(photos.map((p) => p.toDomain().localPath),
          containsAll(['/p1.jpg', '/p2.jpg']));
    });

    test('Immutable InventoryEvent recording and history', () async {
      await db
          .into(db.workspaces)
          .insert(WorkspacesCompanion.insert(id: 'ws_1', name: 'WS 1'));
      await db.into(db.items).insert(ItemsCompanion.insert(
          id: 'item_1', workspaceId: 'ws_1', sku: 'SKU-1', title: 'Title'));

      final event = InventoryEvent(
        id: 'evt_1',
        workspaceId: 'ws_1',
        itemId: 'item_1',
        type: InventoryEventType.moved,
        fromBinId: 'bin_a',
        toBinId: 'bin_b',
        occurredAt: now,
      );

      await db.into(db.inventoryEvents).insert(InventoryEventsCompanion.insert(
            id: event.id,
            workspaceId: event.workspaceId,
            itemId: event.itemId,
            type: event.type.name,
            fromBinId: Value(event.fromBinId),
            toBinId: Value(event.toBinId),
            occurredAt: Value(event.occurredAt),
          ));

      final events = await (db.select(db.inventoryEvents)
            ..where((t) => t.itemId.equals('item_1')))
          .get();
      expect(events.length, 1);
      final domainEvent = events.first.toDomain();
      expect(domainEvent.type, InventoryEventType.moved);
      expect(domainEvent.fromBinId, 'bin_a');
      expect(domainEvent.toBinId, 'bin_b');
    });
  });
}
