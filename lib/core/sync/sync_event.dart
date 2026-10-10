enum SyncEventType {
  itemCreated,
  itemUpdated,
  itemMoved,
  itemSold,
  itemReturned
}

class SyncEvent {
  const SyncEvent(
      {required this.id,
      required this.type,
      required this.entityId,
      required this.occurredAt});
  final String id;
  final SyncEventType type;
  final String entityId;
  final DateTime occurredAt;
}
