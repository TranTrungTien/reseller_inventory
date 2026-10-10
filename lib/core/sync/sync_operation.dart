import 'sync_foundation.dart';

class SyncOperation {
  const SyncOperation({
    required this.id,
    required this.workspaceId,
    required this.entityType,
    required String entityId,
    required this.operationType,
    required this.payload,
    this.status = SyncStatus.pending,
    this.retryCount = 0,
    required this.createdAt,
    this.syncedAt,
    this.errorMessage,
  }) : _entityId = entityId;

  final String id;
  final String workspaceId;
  final String entityType;
  final String _entityId;
  String get entityId => _entityId;
  final SyncOperationType operationType;
  final String payload;
  final SyncStatus status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final String? errorMessage;

  SyncOperation copyWith({
    String? id,
    String? workspaceId,
    String? entityType,
    String? entityId,
    SyncOperationType? operationType,
    String? payload,
    SyncStatus? status,
    int? retryCount,
    DateTime? createdAt,
    DateTime? syncedAt,
    String? errorMessage,
  }) {
    return SyncOperation(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? _entityId,
      operationType: operationType ?? this.operationType,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
