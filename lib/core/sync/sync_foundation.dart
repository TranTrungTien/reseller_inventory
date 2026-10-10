enum SyncStatus {
  pending,
  syncing,
  synced,
  failed,
}

enum SyncOperationType {
  create,
  update,
  delete,
  move,
}

abstract class SyncEngine {
  Future<void> enqueueOperation({
    required String workspaceId,
    required String entityType,
    required String entityId,
    required SyncOperationType operationType,
    required Map<String, dynamic> payload,
  });

  Future<void> processPendingSync();
}
