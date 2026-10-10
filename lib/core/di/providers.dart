import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../analytics/analytics_service.dart';
import '../config/app_config.dart';
import '../logging/app_logger.dart';
import '../permissions/permission_service.dart';
import '../scanner/scanner_service.dart';
import '../scanner/scanner_controller.dart';
import '../storage/image_storage_service.dart';
import '../storage/image_capture_service.dart';
import '../sync/sync_foundation.dart';
import '../database/app_database.dart';
import '../database/connection.dart';
import '../../features/workspace/domain/workspace_repository.dart';
import '../../features/workspace/data/workspace_repository_impl.dart';
import '../../features/workspace/domain/location_repository.dart';
import '../../features/workspace/data/location_repository_impl.dart';
import '../../features/bins/domain/bin_repository.dart';
import '../../features/bins/data/bin_repository_impl.dart';
import '../../features/inventory/domain/item_repository.dart';
import '../../features/inventory/data/item_repository_impl.dart';
import '../../features/inventory/domain/inventory_repository.dart';
import '../../features/inventory/data/inventory_repository_impl.dart';
import '../../features/inventory/domain/find_tracker.dart';
import '../../features/scan/domain/turbo_intake_service.dart';
import '../../features/scan/presentation/turbo_intake_controller.dart';

class DefaultSyncEngine implements SyncEngine {
  @override
  Future<void> enqueueOperation({
    required String workspaceId,
    required String entityType,
    required String entityId,
    required SyncOperationType operationType,
    required Map<String, dynamic> payload,
  }) async {
    // Enqueue outbox operation logic
  }

  @override
  Future<void> processPendingSync() async {
    // Process pending outbox sync
  }
}

// Infrastructure Providers
final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.development();
});

final appLoggerProvider = Provider<AppLogger>((ref) {
  return const ConsoleLogger();
});

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return const ConsoleAnalyticsService();
});

final findTrackerProvider = Provider<FindTracker>((ref) {
  return FindTracker();
});

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return const DefaultPermissionService();
});

final scannerServiceProvider = Provider<BarcodeScannerService>((ref) {
  return StubBarcodeScannerService();
});

final scannerControllerProvider =
    StateNotifierProvider<ScannerController, ScannerState>((ref) {
  final permService = ref.watch(permissionServiceProvider);
  return ScannerController(permissionService: permService);
});

final imageCaptureServiceProvider = Provider<ImageCaptureService>((ref) {
  return DefaultImageCaptureService();
});

final imageStorageServiceProvider = Provider<ImageStorageService>((ref) {
  return const LocalImageStorageService('/tmp/binly_images');
});

final syncEngineProvider = Provider<SyncEngine>((ref) {
  return DefaultSyncEngine();
});

// Database Provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openDatabaseConnection());
  ref.onDispose(() => db.close());
  return db;
});

// Repository Providers
final workspaceRepositoryProvider = Provider<WorkspaceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return WorkspaceRepositoryImpl(db);
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return LocationRepositoryImpl(db);
});

final binRepositoryProvider = Provider<BinRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BinRepositoryImpl(db);
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ItemRepositoryImpl(db);
});

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return InventoryRepositoryImpl(db);
});

// Turbo Intake Service Provider
final turboIntakeServiceProvider = Provider<TurboIntakeService>((ref) {
  final itemRepo = ref.watch(itemRepositoryProvider);
  final invRepo = ref.watch(inventoryRepositoryProvider);
  final imgStorage = ref.watch(imageStorageServiceProvider);
  final syncEng = ref.watch(syncEngineProvider);

  return TurboIntakeService(
    itemRepository: itemRepo,
    inventoryRepository: invRepo,
    imageStorageService: imgStorage,
    syncEngine: syncEng,
  );
});

// Turbo Intake Controller Provider
final turboIntakeControllerProvider =
    StateNotifierProvider<TurboIntakeController, TurboIntakeState>((ref) {
  final service = ref.watch(turboIntakeServiceProvider);
  return TurboIntakeController(turboIntakeService: service);
});

// Active Workspace Provider
final currentWorkspaceIdProvider =
    StateProvider<String>((ref) => 'default_workspace');
