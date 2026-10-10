import '../../features/workspace/domain/workspace.dart';
import '../../features/workspace/domain/location.dart';
import '../../features/workspace/domain/device.dart';
import '../../features/bins/domain/bin.dart';
import '../../features/inventory/domain/item.dart';
import '../../features/inventory/domain/item_photo.dart';
import '../../features/inventory/domain/inventory_event.dart';
import '../../features/inventory/domain/marketplace_reference.dart';
import '../sync/sync_operation.dart';
import '../sync/sync_foundation.dart';
import '../domain/value_objects/enums.dart';
import '../domain/value_objects/money.dart';
import 'app_database.dart';

extension WorkspaceMapper on WorkspaceData {
  Workspace toDomain() {
    return Workspace(
      id: id,
      name: name,
      code: code,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension LocationMapper on LocationData {
  Location toDomain() {
    return Location(
      id: id,
      workspaceId: workspaceId,
      name: name,
      code: code,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

extension BinMapper on BinData {
  Bin toDomain() {
    return Bin(
      id: id,
      workspaceId: workspaceId,
      locationId: locationId,
      code: code,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

extension ItemMapper on ItemData {
  Item toDomain() {
    return Item(
      id: id,
      workspaceId: workspaceId,
      sku: sku,
      title: title,
      description: description,
      status: _parseItemStatus(status),
      locationId: locationId,
      binId: binId,
      cost: costMinorUnits != null
          ? Money.fromMinorUnits(costMinorUnits!, currency)
          : null,
      currency: currency,
      brand: brand,
      category: category,
      size: size,
      color: color,
      condition: condition,
      source: source,
      sourceDate: sourceDate,
      soldAt: soldAt,
      salePrice: salePriceMinorUnits != null
          ? Money.fromMinorUnits(salePriceMinorUnits!, currency)
          : null,
      marketplaceOrderRef: marketplaceOrderRef,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      revision: revision,
    );
  }

  static ItemStatus _parseItemStatus(String value) {
    return ItemStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ItemStatus.stored,
    );
  }
}

extension ItemPhotoMapper on ItemPhotoData {
  ItemPhoto toDomain() {
    return ItemPhoto(
      id: id,
      itemId: itemId,
      localPath: localPath,
      remoteUrl: remoteUrl,
      position: position,
      uploadStatus: _parseUploadStatus(uploadStatus),
      createdAt: createdAt,
    );
  }

  static PhotoUploadStatus _parseUploadStatus(String value) {
    return PhotoUploadStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => PhotoUploadStatus.pending,
    );
  }
}

extension InventoryEventMapper on InventoryEventData {
  InventoryEvent toDomain() {
    return InventoryEvent(
      id: id,
      workspaceId: workspaceId,
      itemId: itemId,
      type: _parseEventType(type),
      fromLocationId: fromLocationId,
      fromBinId: fromBinId,
      toLocationId: toLocationId,
      toBinId: toBinId,
      note: note,
      occurredAt: occurredAt,
      synced: synced,
    );
  }

  static InventoryEventType _parseEventType(String value) {
    return InventoryEventType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => InventoryEventType.stored,
    );
  }
}

extension MarketplaceReferenceMapper on MarketplaceReferenceData {
  MarketplaceReference toDomain() {
    return MarketplaceReference(
      id: id,
      itemId: itemId,
      platform: platform,
      externalId: externalId,
      listingUrl: listingUrl,
      status: status,
      listedAt: listedAt,
      soldAt: soldAt,
      price: priceMinorUnits != null
          ? Money.fromMinorUnits(priceMinorUnits!, currency)
          : null,
    );
  }
}

extension SyncOperationMapper on SyncOperationData {
  SyncOperation toDomain() {
    return SyncOperation(
      id: id,
      workspaceId: workspaceId,
      entityType: entityType,
      entityId: entityId,
      operationType: _parseOpType(operationType),
      payload: payload,
      status: _parseSyncStatus(status),
      retryCount: retryCount,
      createdAt: createdAt,
      syncedAt: syncedAt,
      errorMessage: errorMessage,
    );
  }

  static SyncOperationType _parseOpType(String value) {
    return SyncOperationType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => SyncOperationType.create,
    );
  }

  static SyncStatus _parseSyncStatus(String value) {
    return SyncStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => SyncStatus.pending,
    );
  }
}

extension DeviceMapper on DeviceData {
  Device toDomain() {
    return Device(
      id: id,
      workspaceId: workspaceId,
      name: name,
      platform: platform,
      lastSeenAt: lastSeenAt,
    );
  }
}
