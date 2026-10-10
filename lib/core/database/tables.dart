import 'package:drift/drift.dart';

@DataClassName('WorkspaceData')
class Workspaces extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LocationData')
class Locations extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BinData')
@TableIndex(
    name: 'bins_location_code_idx', columns: {#locationId, #code}, unique: true)
class Bins extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get locationId => text()();
  TextColumn get code => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ItemData')
@TableIndex(
    name: 'items_workspace_sku_idx',
    columns: {#workspaceId, #sku},
    unique: true)
class Items extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get sku => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('stored'))();
  TextColumn get locationId => text().nullable()();
  TextColumn get binId => text().nullable()();
  IntColumn get costMinorUnits => integer().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get brand => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get size => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get condition => text().nullable()();
  TextColumn get source => text().nullable()();
  DateTimeColumn get sourceDate => dateTime().nullable()();
  DateTimeColumn get soldAt => dateTime().nullable()();
  IntColumn get salePriceMinorUnits => integer().nullable()();
  TextColumn get marketplaceOrderRef => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ItemPhotoData')
class ItemPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text()();
  TextColumn get localPath => text().nullable()();
  TextColumn get remoteUrl => text().nullable()();
  IntColumn get position => integer().withDefault(const Constant(0))();
  TextColumn get uploadStatus =>
      text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InventoryEventData')
class InventoryEvents extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get itemId => text()();
  TextColumn get type => text()();
  TextColumn get fromLocationId => text().nullable()();
  TextColumn get fromBinId => text().nullable()();
  TextColumn get toLocationId => text().nullable()();
  TextColumn get toBinId => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MarketplaceReferenceData')
class MarketplaceReferences extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text()();
  TextColumn get platform => text()();
  TextColumn get externalId => text()();
  TextColumn get listingUrl => text().nullable()();
  TextColumn get status => text().nullable()();
  DateTimeColumn get listedAt => dateTime().nullable()();
  DateTimeColumn get soldAt => dateTime().nullable()();
  IntColumn get priceMinorUnits => integer().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncOperationData')
class SyncOperations extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operationType => text()();
  TextColumn get payload => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DeviceData')
class Devices extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get name => text()();
  TextColumn get platform => text()();
  DateTimeColumn get lastSeenAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
