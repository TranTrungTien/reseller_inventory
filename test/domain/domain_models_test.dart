import 'package:flutter_test/flutter_test.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/enums.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/money.dart';
import 'package:reseller_inventory_app/features/workspace/domain/workspace.dart';
import 'package:reseller_inventory_app/features/workspace/domain/location.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item_photo.dart';
import 'package:reseller_inventory_app/features/inventory/domain/inventory_event.dart';

void main() {
  group('Domain Entities', () {
    final now = DateTime.now();

    test('Workspace copyWith works correctly', () {
      final ws = Workspace(
        id: 'ws_1',
        name: 'Main Workspace',
        createdAt: now,
        updatedAt: now,
      );

      final updated = ws.copyWith(name: 'Updated Workspace');
      expect(updated.id, 'ws_1');
      expect(updated.name, 'Updated Workspace');
    });

    test('Location -> Bin -> Item hierarchy models instantiate properly', () {
      final location = Location(
        id: 'loc_1',
        workspaceId: 'ws_1',
        name: 'Garage',
        code: 'GARAGE',
        createdAt: now,
        updatedAt: now,
      );

      final bin = Bin(
        id: 'bin_1',
        workspaceId: 'ws_1',
        locationId: location.id,
        code: 'A01',
        createdAt: now,
        updatedAt: now,
      );

      final item = Item(
        id: 'item_1',
        workspaceId: 'ws_1',
        sku: 'SKU-1001',
        title: 'Vintage Nike Jacket',
        status: ItemStatus.stored,
        locationId: location.id,
        binId: bin.id,
        cost: Money.fromMajorUnits(15.00, 'USD'),
        createdAt: now,
        updatedAt: now,
      );

      expect(item.binId, bin.id);
      expect(item.locationId, location.id);
      expect(item.cost?.amountInMinorUnits, 1500);
      expect(item.status, ItemStatus.stored);
    });

    test('ItemPhoto supports position and status', () {
      final photo = ItemPhoto(
        id: 'photo_1',
        itemId: 'item_1',
        localPath: '/path/photo.jpg',
        position: 1,
        uploadStatus: PhotoUploadStatus.pending,
        createdAt: now,
      );

      expect(photo.position, 1);
      expect(photo.uploadStatus, PhotoUploadStatus.pending);
    });

    test('InventoryEvent holds immutable historical record', () {
      final event = InventoryEvent(
        id: 'evt_1',
        workspaceId: 'ws_1',
        itemId: 'item_1',
        type: InventoryEventType.moved,
        fromBinId: 'bin_1',
        toBinId: 'bin_2',
        occurredAt: now,
      );

      expect(event.type, InventoryEventType.moved);
      expect(event.fromBinId, 'bin_1');
      expect(event.toBinId, 'bin_2');
    });
  });
}
