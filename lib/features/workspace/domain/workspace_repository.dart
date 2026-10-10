import 'workspace.dart';

abstract class WorkspaceRepository {
  Future<Workspace?> getWorkspace(String id);
  Future<List<Workspace>> getAllWorkspaces();
  Future<void> saveWorkspace(Workspace workspace);
  Future<void> deleteWorkspace(String id);
}
