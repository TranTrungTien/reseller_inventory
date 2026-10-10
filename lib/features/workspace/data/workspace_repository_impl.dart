import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/mappers.dart';
import '../domain/workspace.dart';
import '../domain/workspace_repository.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  const WorkspaceRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Workspace?> getWorkspace(String id) async {
    final query = _db.select(_db.workspaces)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<Workspace>> getAllWorkspaces() async {
    final rows = await _db.select(_db.workspaces).get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> saveWorkspace(Workspace workspace) async {
    await _db.into(_db.workspaces).insertOnConflictUpdate(
          WorkspacesCompanion.insert(
            id: workspace.id,
            name: workspace.name,
            code: Value(workspace.code),
            description: Value(workspace.description),
            createdAt: Value(workspace.createdAt),
            updatedAt: Value(workspace.updatedAt),
          ),
        );
  }

  @override
  Future<void> deleteWorkspace(String id) async {
    await (_db.delete(_db.workspaces)..where((tbl) => tbl.id.equals(id))).go();
  }
}
