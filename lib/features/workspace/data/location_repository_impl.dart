import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/mappers.dart';
import '../domain/location.dart';
import '../domain/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  const LocationRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Location?> getLocation(String id) async {
    final query = _db.select(_db.locations)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<Location>> getLocationsForWorkspace(String workspaceId,
      {bool includeArchived = false}) async {
    final query = _db.select(_db.locations)
      ..where((tbl) {
        final wsFilter = tbl.workspaceId.equals(workspaceId);
        return includeArchived ? wsFilter : wsFilter & tbl.deletedAt.isNull();
      })
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> saveLocation(Location location) async {
    await _db.into(_db.locations).insertOnConflictUpdate(
          LocationsCompanion.insert(
            id: location.id,
            workspaceId: location.workspaceId,
            name: location.name,
            code: Value(location.code),
            description: Value(location.description),
            createdAt: Value(location.createdAt),
            updatedAt: Value(location.updatedAt),
            deletedAt: Value(location.deletedAt),
          ),
        );
  }

  @override
  Future<void> archiveLocation(String id) async {
    await (_db.update(_db.locations)..where((tbl) => tbl.id.equals(id))).write(
      LocationsCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteLocation(String id) async {
    await (_db.delete(_db.locations)..where((tbl) => tbl.id.equals(id))).go();
  }
}
