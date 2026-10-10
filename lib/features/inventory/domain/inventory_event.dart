import '../../../core/domain/value_objects/enums.dart';

class InventoryEvent {
  const InventoryEvent({
    required this.id,
    required this.workspaceId,
    required this.itemId,
    required this.type,
    this.fromLocationId,
    this.fromBinId,
    this.toLocationId,
    this.toBinId,
    this.note,
    required this.occurredAt,
    this.synced = false,
  });

  final String id;
  final String workspaceId;
  final String itemId;
  final InventoryEventType type;
  final String? fromLocationId;
  final String? fromBinId;
  final String? toLocationId;
  final String? toBinId;
  final String? note;
  final DateTime occurredAt;
  final bool synced;

  InventoryEvent copyWith({
    String? id,
    String? workspaceId,
    String? itemId,
    InventoryEventType? type,
    String? fromLocationId,
    String? fromBinId,
    String? toLocationId,
    String? toBinId,
    String? note,
    DateTime? occurredAt,
    bool? synced,
  }) {
    return InventoryEvent(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      itemId: itemId ?? this.itemId,
      type: type ?? this.type,
      fromLocationId: fromLocationId ?? this.fromLocationId,
      fromBinId: fromBinId ?? this.fromBinId,
      toLocationId: toLocationId ?? this.toLocationId,
      toBinId: toBinId ?? this.toBinId,
      note: note ?? this.note,
      occurredAt: occurredAt ?? this.occurredAt,
      synced: synced ?? this.synced,
    );
  }
}
