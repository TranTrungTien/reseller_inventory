import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../../../core/storage/image_storage_service.dart';
import '../../../core/sync/sync_foundation.dart';
import '../../inventory/domain/item.dart';
import '../../inventory/domain/item_photo.dart';
import '../../inventory/domain/inventory_event.dart';
import '../../inventory/domain/item_repository.dart';
import '../../inventory/domain/inventory_repository.dart';
import 'turbo_intake_session.dart';

class TurboIntakeCaptureResult {
  const TurboIntakeCaptureResult({
    required this.item,
    required this.photo,
    required this.event,
  });

  final Item item;
  final ItemPhoto photo;
  final InventoryEvent event;
}

class TurboIntakeService {
  const TurboIntakeService({
    required this.itemRepository,
    required this.inventoryRepository,
    required this.imageStorageService,
    required this.syncEngine,
  });

  final ItemRepository itemRepository;
  final InventoryRepository inventoryRepository;
  final ImageStorageService imageStorageService;
  final SyncEngine syncEngine;

  static String generateSKU() {
    final now = DateTime.now();
    final dateStr = DateFormat('yyyyMMdd').format(now);
    final randomSuffix = const Uuid().v4().substring(0, 4).toUpperCase();
    return 'SKU-$dateStr-$randomSuffix';
  }

  Future<TurboIntakeCaptureResult> captureItemInBin({
    required TurboIntakeSession session,
    required File imageFile,
    String? title,
  }) async {
    final now = DateTime.now();
    final itemId = const Uuid().v4();
    final photoId = const Uuid().v4();
    final eventId = const Uuid().v4();
    final sku = generateSKU();

    // 1. Process and save image persistently
    final imageResult =
        await imageStorageService.processAndSavePhoto(imageFile, itemId);

    // 2. Build Item domain entity
    final item = Item(
      id: itemId,
      workspaceId: session.workspaceId,
      sku: sku,
      title: title ?? 'Untitled item',
      status: ItemStatus.stored,
      locationId: session.locationId,
      binId: session.binId,
      cost: session.effectiveCostPerItem,
      source: session.defaultSource,
      createdAt: now,
      updatedAt: now,
      revision: 1,
    );

    // 3. Build ItemPhoto domain entity
    final photo = ItemPhoto(
      id: photoId,
      itemId: itemId,
      localPath: imageResult.localPath,
      position: 0,
      uploadStatus: PhotoUploadStatus.pending,
      createdAt: now,
    );

    // 4. Build immutable InventoryEvent entity
    final event = InventoryEvent(
      id: eventId,
      workspaceId: session.workspaceId,
      itemId: itemId,
      type: InventoryEventType.itemCreated,
      toLocationId: session.locationId,
      toBinId: session.binId,
      note: 'Captured via Turbo Intake',
      occurredAt: now,
    );

    // Atomic local persistence
    await itemRepository.saveItem(item);
    await itemRepository.saveItemPhoto(photo);
    await inventoryRepository.recordEvent(event);

    // Enqueue Outbox Sync Operation
    await syncEngine.enqueueOperation(
      workspaceId: session.workspaceId,
      entityType: 'item',
      entityId: itemId,
      operationType: SyncOperationType.create,
      payload: {
        'id': item.id,
        'sku': item.sku,
        'title': item.title,
        'binId': item.binId,
        'locationId': item.locationId,
      },
    );

    return TurboIntakeCaptureResult(
      item: item,
      photo: photo,
      event: event,
    );
  }
}
