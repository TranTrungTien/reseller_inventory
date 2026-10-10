import '../../../core/domain/value_objects/enums.dart';
import 'item.dart';
import 'item_photo.dart';

abstract class ItemRepository {
  Future<Item?> getItem(String id);
  Future<Item?> getItemBySku(String workspaceId, String sku);
  Future<List<Item>> getItemsForWorkspace(String workspaceId);
  Future<List<Item>> getItemsForBin(String binId);
  Future<List<Item>> getReadyToPickItems(String workspaceId);
  Future<List<Item>> searchItems(
    String workspaceId,
    String query, {
    ItemStatus? statusFilter,
    bool needsDetailsOnly = false,
  });
  Future<void> saveItem(Item item);
  Future<void> updateItemLocation(
      String itemId, String? locationId, String? binId);
  Future<void> deleteItem(String id);

  // Photos
  Future<List<ItemPhoto>> getPhotosForItem(String itemId);
  Future<void> saveItemPhoto(ItemPhoto photo);
  Future<void> deleteItemPhoto(String photoId);
}
