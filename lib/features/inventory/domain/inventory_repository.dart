import 'inventory_event.dart';

abstract class InventoryRepository {
  Future<void> recordEvent(InventoryEvent event);
  Future<List<InventoryEvent>> getEventsForItem(String itemId);
  Future<List<InventoryEvent>> getEventsForWorkspace(String workspaceId);
  Future<List<InventoryEvent>> getUnsyncedEvents(String workspaceId);
  Future<void> markEventsSynced(List<String> eventIds);
}
