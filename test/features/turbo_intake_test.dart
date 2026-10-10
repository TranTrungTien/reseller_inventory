import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/enums.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/money.dart';
import 'package:reseller_inventory_app/core/storage/image_storage_service.dart';
import 'package:reseller_inventory_app/core/di/providers.dart';
import 'package:reseller_inventory_app/features/inventory/data/inventory_repository_impl.dart';
import 'package:reseller_inventory_app/features/inventory/data/item_repository_impl.dart';
import 'package:reseller_inventory_app/features/scan/domain/turbo_intake_service.dart';
import 'package:reseller_inventory_app/features/scan/domain/turbo_intake_session.dart';
import 'package:reseller_inventory_app/features/scan/presentation/turbo_intake_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Turbo Intake Session & Service Tests', () {
    late Directory tempDir;
    late AppDatabase db;
    late ItemRepositoryImpl itemRepo;
    late InventoryRepositoryImpl invRepo;
    late LocalImageStorageService imgStorage;
    late DefaultSyncEngine syncEngine;
    late TurboIntakeService intakeService;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('binly_turbo_test_');
      db = AppDatabase(NativeDatabase.memory());
      itemRepo = ItemRepositoryImpl(db);
      invRepo = InventoryRepositoryImpl(db);
      imgStorage = LocalImageStorageService(tempDir.path);
      syncEngine = DefaultSyncEngine();

      intakeService = TurboIntakeService(
        itemRepository: itemRepo,
        inventoryRepository: invRepo,
        imageStorageService: imgStorage,
        syncEngine: syncEngine,
      );
    });

    tearDown(() async {
      await db.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Session cost calculation shortcuts', () {
      final session1 = TurboIntakeSession(
        id: 's1',
        workspaceId: 'ws_1',
        locationId: 'loc_1',
        binId: 'bin_1',
        binCode: 'A01',
        startedAt: DateTime.now(),
        defaultCost: Money.fromMajorUnits(4.50, 'USD'),
      );

      expect(session1.effectiveCostPerItem?.amountInMajorUnits, 4.50);

      // Total Haul Cost Allocation ($100 / 20 items = $5 per item)
      final session2 = TurboIntakeSession(
        id: 's2',
        workspaceId: 'ws_1',
        locationId: 'loc_1',
        binId: 'bin_1',
        binCode: 'A01',
        startedAt: DateTime.now(),
        totalHaulCost: Money.fromMajorUnits(100.00, 'USD'),
        haulItemCount: 20,
      );

      expect(session2.effectiveCostPerItem?.amountInMajorUnits, 5.00);
    });

    test('Single capture generates SKU, Item, ItemPhoto, InventoryEvent',
        () async {
      final session = TurboIntakeSession(
        id: 's1',
        workspaceId: 'ws_1',
        locationId: 'loc_garage',
        binId: 'bin_a01',
        binCode: 'A01',
        startedAt: DateTime.now(),
        defaultCost: Money.fromMajorUnits(3.00, 'USD'),
      );

      final dummyPhoto = File('${tempDir.path}/dummy.jpg');
      await dummyPhoto.writeAsString('test_photo_bytes');

      final result = await intakeService.captureItemInBin(
        session: session,
        imageFile: dummyPhoto,
      );

      expect(result.item.binId, 'bin_a01');
      expect(result.item.locationId, 'loc_garage');
      expect(result.item.status, ItemStatus.stored);
      expect(result.item.cost?.amountInMajorUnits, 3.00);
      expect(result.item.sku, startsWith('SKU-'));

      // Check DB queries
      final storedItems = await itemRepo.getItemsForBin('bin_a01');
      expect(storedItems.length, 1);
      expect(storedItems.first.id, result.item.id);

      final events = await invRepo.getEventsForItem(result.item.id);
      expect(events.length, 1);
      expect(events.first.type, InventoryEventType.itemCreated);
      expect(events.first.toBinId, 'bin_a01');
    });

    test('Continuous multiple captures into same locked bin', () async {
      final session = TurboIntakeSession(
        id: 's1',
        workspaceId: 'ws_1',
        locationId: 'loc_1',
        binId: 'bin_locked',
        binCode: 'B12',
        startedAt: DateTime.now(),
      );

      final dummyPhoto = File('${tempDir.path}/dummy.jpg');
      await dummyPhoto.writeAsString('bytes');

      for (int i = 0; i < 5; i++) {
        await intakeService.captureItemInBin(
          session: session,
          imageFile: dummyPhoto,
        );
      }

      final itemsInBin = await itemRepo.getItemsForBin('bin_locked');
      expect(itemsInBin.length, 5);

      // Verify SKUs are unique
      final skus = itemsInBin.map((i) => i.sku).toSet();
      expect(skus.length, 5);
    });

    test('TurboIntakeController state management & bin locking', () async {
      final controller = TurboIntakeController(
        turboIntakeService: intakeService,
      );

      expect(controller.debugState.isBinLocked, isFalse);

      controller.lockBin(
        workspaceId: 'ws_1',
        locationId: 'loc_1',
        binId: 'bin_100',
        binCode: 'A99',
      );

      expect(controller.debugState.isBinLocked, isTrue);
      expect(controller.debugState.session?.binCode, 'A99');

      final dummyPhoto = File('${tempDir.path}/dummy.jpg');
      await dummyPhoto.writeAsString('bytes');

      final success = await controller.capturePhoto(dummyPhoto);
      expect(success, isTrue);
      expect(controller.debugState.session?.sessionCount, 1);

      controller.unlockBin();
      expect(controller.debugState.isBinLocked, isFalse);
    });
  });
}
