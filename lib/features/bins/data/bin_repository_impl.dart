import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/mappers.dart';
import '../domain/bin.dart';
import '../domain/bin_repository.dart';

class BinRepositoryImpl implements BinRepository {
  const BinRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Bin?> getBin(String id) async {
    final query = _db.select(_db.bins)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<Bin?> getBinByCode(String locationId, String code) async {
    final query = _db.select(_db.bins)
      ..where((tbl) =>
          tbl.locationId.equals(locationId) &
          tbl.code.equals(code) &
          tbl.deletedAt.isNull());
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<Bin>> getBinsForLocation(String locationId,
      {bool includeArchived = false}) async {
    final query = _db.select(_db.bins)
      ..where((tbl) {
        final locFilter = tbl.locationId.equals(locationId);
        return includeArchived ? locFilter : locFilter & tbl.deletedAt.isNull();
      })
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.code)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<List<Bin>> getBinsForWorkspace(String workspaceId,
      {bool includeArchived = false}) async {
    final query = _db.select(_db.bins)
      ..where((tbl) {
        final wsFilter = tbl.workspaceId.equals(workspaceId);
        return includeArchived ? wsFilter : wsFilter & tbl.deletedAt.isNull();
      })
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.code)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<List<Bin>> searchBins(String workspaceId, String query,
      {bool includeArchived = false}) async {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      return getBinsForWorkspace(workspaceId, includeArchived: includeArchived);
    }
    final pattern = '%$cleanQuery%';
    final q = _db.select(_db.bins)
      ..where((tbl) {
        final matchFilter = tbl.workspaceId.equals(workspaceId) &
            (tbl.code.lower().like(pattern) |
                tbl.description.lower().like(pattern));
        return includeArchived
            ? matchFilter
            : matchFilter & tbl.deletedAt.isNull();
      })
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.code)]);

    final rows = await q.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<int> getItemCountForBin(String binId) async {
    final countExpression = _db.items.id.count();
    final query = _db.selectOnly(_db.items)
      ..addColumns([countExpression])
      ..where(_db.items.binId.equals(binId) & _db.items.deletedAt.isNull());
    final result = await query.getSingle();
    return result.read(countExpression) ?? 0;
  }

  @override
  Future<bool> isBinCodeAvailable(String locationId, String code,
      {String? excludeBinId}) async {
    final cleanCode = code.trim().toUpperCase();
    final query = _db.select(_db.bins)
      ..where((tbl) {
        var expr = tbl.locationId.equals(locationId) &
            tbl.code.equals(cleanCode) &
            tbl.deletedAt.isNull();
        if (excludeBinId != null) {
          expr = expr & tbl.id.equals(excludeBinId).not();
        }
        return expr;
      });
    final existing = await query.getSingleOrNull();
    return existing == null;
  }

  @override
  Future<void> saveBin(Bin bin) async {
    await _db.into(_db.bins).insertOnConflictUpdate(
          BinsCompanion.insert(
            id: bin.id,
            workspaceId: bin.workspaceId,
            locationId: bin.locationId,
            code: bin.code.trim().toUpperCase(),
            description: Value(bin.description),
            createdAt: Value(bin.createdAt),
            updatedAt: Value(bin.updatedAt),
            deletedAt: Value(bin.deletedAt),
          ),
        );
  }

  @override
  Future<void> archiveBin(String id) async {
    await (_db.update(_db.bins)..where((tbl) => tbl.id.equals(id))).write(
      BinsCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteBin(String id) async {
    await (_db.delete(_db.bins)..where((tbl) => tbl.id.equals(id))).go();
  }
}
