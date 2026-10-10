import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/analytics/analytics_service.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/enums.dart';
import 'package:reseller_inventory_app/features/inventory/domain/find_tracker.dart';
import 'package:reseller_inventory_app/features/inventory/domain/item.dart';
import 'package:reseller_inventory_app/features/inventory/domain/inventory_event.dart';
import 'package:reseller_inventory_app/features/inventory/data/item_repository_impl.dart';
import 'package:reseller_inventory_app/features/inventory/data/inventory_repository_impl.dart';

class MockAnalyticsService implements AnalyticsService {
  final List<String> loggedEvents = [];

  @override
  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    loggedEvents.add(name);
  }

  @override
  void logInventorySearch(String query, int resultCount) =>
      logEvent('inventory_search');

  @override
  void logItemFound(String itemId, String? binId, Duration duration) =>
      logEvent('item_found');

  @override
  void logItemNotFound(String itemId, String? binId) =>
      logEvent('item_not_found');

  @override
  void logItemMarkedMissing(String itemId, String? binId) =>
      logEvent('item_marked_missing');

  @override
  void logItemFoundAgain(String itemId, String? newBinId) =>
      logEvent('item_found_again');
}

void main() {
  group('Find Flow & Retrieval Loop Tests', () {
    late AppDatabase db;
    late ItemRepositoryImpl itemRepo;
    late InventoryRepositoryImpl invRepo;
    late MockAnalyticsService mockAnalytics;
    late FindTracker tracker;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      itemRepo = ItemRepositoryImpl(db);
      invRepo = InventoryRepositoryImpl(db);
      mockAnalytics = MockAnalyticsService();
      tracker = FindTracker();
    });

    tearDown(() async {
      await db.close();
    });

    test('FindTracker calculates search-to-found elapsed duration', () async {
      tracker.startFindIntent('item_1');
      await Future.delayed(const Duration(milliseconds: 50));
      final duration = tracker.completeFindIntent('item_1');

      expect(duration.inMilliseconds, greaterThanOrEqualTo(40));
    });

    test('FOUND IT records inventory event and analytics', () async {
      final now = DateTime.now();
      final item = Item(
          id: 'i100',
          workspaceId: 'ws_1',
          sku: 'S100',
          title: 'Find Item',
          binId: 'bin_a01',
          createdAt: now,
          updatedAt: now);
      await itemRepo.saveItem(item);

      tracker.startFindIntent('i100');
      final duration = tracker.completeFindIntent('i100');

      await invRepo.recordEvent(
        InventoryEvent(
          id: 'e1',
          workspaceId: 'ws_1',
          itemId: 'i100',
          type: InventoryEventType.found,
          toBinId: 'bin_a01',
          occurredAt: now,
        ),
      );

      mockAnalytics.logItemFound('i100', 'bin_a01', duration);

      final events = await invRepo.getEventsForItem('i100');
      expect(events.length, 1);
      expect(events.first.type, InventoryEventType.found);
      expect(mockAnalytics.loggedEvents, contains('item_found'));
    });

    test(
        'Marking Missing updates item state, creates InventoryEvent and fires analytics',
        () async {
      final now = DateTime.now();
      final item = Item(
          id: 'i101',
          workspaceId: 'ws_1',
          sku: 'S101',
          title: 'Lost Item',
          status: ItemStatus.stored,
          createdAt: now,
          updatedAt: now);
      await itemRepo.saveItem(item);

      // Mark missing
      final missingItem =
          item.copyWith(status: ItemStatus.missing, updatedAt: now);
      await itemRepo.saveItem(missingItem);

      await invRepo.recordEvent(
        InventoryEvent(
          id: 'e2',
          workspaceId: 'ws_1',
          itemId: 'i101',
          type: InventoryEventType.markedMissing,
          occurredAt: now,
        ),
      );

      mockAnalytics.logItemMarkedMissing('i101', null);

      final fetched = await itemRepo.getItem('i101');
      expect(fetched?.status, ItemStatus.missing);
      expect(mockAnalytics.loggedEvents, contains('item_marked_missing'));
    });

    test('FOUND AGAIN (MISSING -> STORED) restores item and reassigns bin',
        () async {
      final now = DateTime.now();
      final item = Item(
          id: 'i102',
          workspaceId: 'ws_1',
          sku: 'S102',
          title: 'Recovered Item',
          status: ItemStatus.missing,
          createdAt: now,
          updatedAt: now);
      await itemRepo.saveItem(item);

      // Transition MISSING -> STORED with bin_b99
      final restoredItem = item.copyWith(
        status: ItemStatus.stored,
        binId: 'bin_b99',
        updatedAt: now,
      );
      await itemRepo.saveItem(restoredItem);

      await invRepo.recordEvent(
        InventoryEvent(
          id: 'e3',
          workspaceId: 'ws_1',
          itemId: 'i102',
          type: InventoryEventType.found,
          toBinId: 'bin_b99',
          note: 'Found again after being missing!',
          occurredAt: now,
        ),
      );

      mockAnalytics.logItemFoundAgain('i102', 'bin_b99');

      final fetched = await itemRepo.getItem('i102');
      expect(fetched?.status, ItemStatus.stored);
      expect(fetched?.binId, 'bin_b99');
      expect(mockAnalytics.loggedEvents, contains('item_found_again'));
    });
  });
}
