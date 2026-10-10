enum ItemStatus {
  draft,
  stored,
  listed,
  sold,
  picked,
  returned,
  missing,
  donated,
  disposed,
  archived,
}

enum InventoryEventType {
  itemCreated,
  stored,
  moved,
  listed,
  sold,
  picked,
  returned,
  markedMissing,
  found,
  donated,
  disposed,
  archived,
}

enum PhotoUploadStatus {
  pending,
  uploading,
  uploaded,
  error,
}
