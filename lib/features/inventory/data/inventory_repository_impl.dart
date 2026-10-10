import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/mappers.dart';
import '../domain/inventory_event.dart';
import '../domain/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  const InventoryRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> recordEvent(InventoryEvent event) async {
    await _db.into(_db.inventoryEvents).insertOnConflictUpdate(
          InventoryEventsCompanion.insert(
            id: event.id,
            workspaceId: event.workspaceId,
            itemId: event.itemId,
            type: event.type.name,
            fromLocationId: Value(event.fromLocationId),
            fromBinId: Value(event.fromBinId),
            toLocationId: Value(event.toLocationId),
            toBinId: Value(event.toBinId),
            note: Value(event.note),
            occurredAt: Value(event.occurredAt),
            synced: Value(event.synced),
          ),
        );
  }

  @override
  Future<List<InventoryEvent>> getEventsForItem(String itemId) async {
    final query = _db.select(_db.inventoryEvents)
      ..where((tbl) => tbl.itemId.equals(itemId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<List<InventoryEvent>> getEventsForWorkspace(String workspaceId) async {
    final query = _db.select(_db.inventoryEvents)
      ..where((tbl) => tbl.workspaceId.equals(workspaceId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<List<InventoryEvent>> getUnsyncedEvents(String workspaceId) async {
    final query = _db.select(_db.inventoryEvents)
      ..where((tbl) =>
          tbl.workspaceId.equals(workspaceId) & tbl.synced.equals(false))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.occurredAt)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> markEventsSynced(List<String> eventIds) async {
    if (eventIds.isEmpty) return;
    await (_db.update(_db.inventoryEvents)
          ..where((tbl) => tbl.id.isIn(eventIds)))
        .write(
      const InventoryEventsCompanion(
        synced: Value(true),
      ),
    );
  }
}
