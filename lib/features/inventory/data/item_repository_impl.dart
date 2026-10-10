import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/mappers.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../domain/item.dart';
import '../domain/item_photo.dart';
import '../domain/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Item?> getItem(String id) async {
    final query = _db.select(_db.items)
      ..where((tbl) => tbl.id.equals(id) & tbl.deletedAt.isNull());
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<Item?> getItemBySku(String workspaceId, String sku) async {
    final query = _db.select(_db.items)
      ..where((tbl) =>
          tbl.workspaceId.equals(workspaceId) &
          tbl.sku.equals(sku) &
          tbl.deletedAt.isNull());
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<Item>> getItemsForWorkspace(String workspaceId) async {
    final query = _db.select(_db.items)
      ..where(
          (tbl) => tbl.workspaceId.equals(workspaceId) & tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<List<Item>> getItemsForBin(String binId) async {
    final query = _db.select(_db.items)
      ..where((tbl) => tbl.binId.equals(binId) & tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<List<Item>> getReadyToPickItems(String workspaceId) async {
    final joined = _db.select(_db.items).join([
      leftOuterJoin(_db.bins, _db.bins.id.equalsExp(_db.items.binId)),
      leftOuterJoin(
          _db.locations, _db.locations.id.equalsExp(_db.items.locationId)),
    ]);

    joined.where(
      _db.items.workspaceId.equals(workspaceId) &
          _db.items.status.equals(ItemStatus.sold.name) &
          _db.items.deletedAt.isNull(),
    );

    // Deterministic physical location hierarchy sort: Location -> Bin -> Title
    joined.orderBy([
      OrderingTerm.asc(_db.locations.name),
      OrderingTerm.asc(_db.bins.code),
      OrderingTerm.asc(_db.items.title),
    ]);

    final rows = await joined.get();
    return rows.map((row) => row.readTable(_db.items).toDomain()).toList();
  }

  @override
  Future<List<Item>> searchItems(
    String workspaceId,
    String query, {
    ItemStatus? statusFilter,
    bool needsDetailsOnly = false,
  }) async {
    final cleanQuery = query.trim().toLowerCase();
    final terms =
        cleanQuery.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();

    // Query joined with Bins and Locations for bin/location code search
    final joined = _db.select(_db.items).join([
      leftOuterJoin(_db.bins, _db.bins.id.equalsExp(_db.items.binId)),
      leftOuterJoin(
          _db.locations, _db.locations.id.equalsExp(_db.items.locationId)),
    ]);

    // Base conditions
    Expression<bool> whereClause = _db.items.workspaceId.equals(workspaceId) &
        _db.items.deletedAt.isNull();

    // Status filter
    if (statusFilter != null) {
      whereClause = whereClause & _db.items.status.equals(statusFilter.name);
    }

    // Needs Details filter (incomplete items from Turbo Intake)
    if (needsDetailsOnly) {
      whereClause = whereClause &
          (_db.items.title.equals('Untitled item') |
              _db.items.title.like('Untitled%'));
    }

    // Multi-term search query matching across title, sku, brand, category, size, color, condition, description, bin code, and location name
    for (final term in terms) {
      final pattern = '%$term%';
      final termMatch = _db.items.title.lower().like(pattern) |
          _db.items.sku.lower().like(pattern) |
          _db.items.brand.lower().like(pattern) |
          _db.items.category.lower().like(pattern) |
          _db.items.size.lower().like(pattern) |
          _db.items.color.lower().like(pattern) |
          _db.items.condition.lower().like(pattern) |
          _db.items.description.lower().like(pattern) |
          _db.bins.code.lower().like(pattern) |
          _db.locations.name.lower().like(pattern);

      whereClause = whereClause & termMatch;
    }

    joined.where(whereClause);
    joined.orderBy([OrderingTerm.desc(_db.items.updatedAt)]);

    final rows = await joined.get();
    return rows.map((row) => row.readTable(_db.items).toDomain()).toList();
  }

  @override
  Future<void> saveItem(Item item) async {
    await _db.into(_db.items).insertOnConflictUpdate(
          ItemsCompanion.insert(
            id: item.id,
            workspaceId: item.workspaceId,
            sku: item.sku,
            title: item.title,
            description: Value(item.description),
            status: Value(item.status.name),
            locationId: Value(item.locationId),
            binId: Value(item.binId),
            costMinorUnits: Value(item.cost?.amountInMinorUnits),
            currency: Value(item.currency),
            brand: Value(item.brand),
            category: Value(item.category),
            size: Value(item.size),
            color: Value(item.color),
            condition: Value(item.condition),
            source: Value(item.source),
            sourceDate: Value(item.sourceDate),
            soldAt: Value(item.soldAt),
            salePriceMinorUnits: Value(item.salePrice?.amountInMinorUnits),
            marketplaceOrderRef: Value(item.marketplaceOrderRef),
            createdAt: Value(item.createdAt),
            updatedAt: Value(item.updatedAt),
            deletedAt: Value(item.deletedAt),
            revision: Value(item.revision),
          ),
        );
  }

  @override
  Future<void> updateItemLocation(
      String itemId, String? locationId, String? binId) async {
    await (_db.update(_db.items)..where((tbl) => tbl.id.equals(itemId))).write(
      ItemsCompanion(
        locationId: Value(locationId),
        binId: Value(binId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_db.update(_db.items)..where((tbl) => tbl.id.equals(id))).write(
      ItemsCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<List<ItemPhoto>> getPhotosForItem(String itemId) async {
    final query = _db.select(_db.itemPhotos)
      ..where((tbl) => tbl.itemId.equals(itemId))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]);
    final rows = await query.get();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> saveItemPhoto(ItemPhoto photo) async {
    await _db.into(_db.itemPhotos).insertOnConflictUpdate(
          ItemPhotosCompanion.insert(
            id: photo.id,
            itemId: photo.itemId,
            localPath: Value(photo.localPath),
            remoteUrl: Value(photo.remoteUrl),
            position: Value(photo.position),
            uploadStatus: Value(photo.uploadStatus.name),
            createdAt: Value(photo.createdAt),
          ),
        );
  }

  @override
  Future<void> deleteItemPhoto(String photoId) async {
    await (_db.delete(_db.itemPhotos)..where((tbl) => tbl.id.equals(photoId)))
        .go();
  }
}
