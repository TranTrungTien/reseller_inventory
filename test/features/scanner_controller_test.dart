import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/permissions/permission_service.dart';
import 'package:reseller_inventory_app/core/qr/qr_service.dart';
import 'package:reseller_inventory_app/core/scanner/scanner_controller.dart';
import 'package:reseller_inventory_app/features/bins/data/bin_repository_impl.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';

class FakePermissionService implements PermissionService {
  PermissionStatus status = PermissionStatus.granted;

  @override
  Future<PermissionStatus> checkPermission(AppPermission permission) async =>
      status;

  @override
  Future<PermissionStatus> requestPermission(AppPermission permission) async =>
      status;

  @override
  Future<bool> openAppSettings() async => true;
}

void main() {
  group('ScannerController State & Debounce Tests', () {
    late FakePermissionService fakePerms;
    late AppDatabase db;
    late BinRepositoryImpl binRepo;

    setUp(() {
      fakePerms = FakePermissionService();
      db = AppDatabase(NativeDatabase.memory());
      binRepo = BinRepositoryImpl(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('initializes permission state', () async {
      final controller = ScannerController(
        permissionService: fakePerms,
      );
      await controller.checkPermission();
      expect(controller.debugState.permissionStatus, PermissionStatus.granted);
    });

    test('debounces identical rapid scans', () async {
      final now = DateTime.now();
      final bin = Bin(
          id: 'bin_10',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'A10',
          createdAt: now,
          updatedAt: now);
      await binRepo.saveBin(bin);

      final controller = ScannerController(
        permissionService: fakePerms,
        debounceDuration: const Duration(seconds: 2),
      );

      final payload = QrService.encodeBinPayload('bin_10');

      // First scan -> resolves
      final res1 = await controller.handleScannedCode(payload, binRepo);
      expect(res1?.status, QrResolutionStatus.valid);

      // Immediate second scan of same payload -> ignored by debounce
      final res2 = await controller.handleScannedCode(payload, binRepo);
      expect(res2, isNull);
    });

    test('ignores scans when scanner is paused', () async {
      final now = DateTime.now();
      final bin = Bin(
          id: 'bin_11',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'A11',
          createdAt: now,
          updatedAt: now);
      await binRepo.saveBin(bin);

      final controller = ScannerController(
        permissionService: fakePerms,
      );

      controller.pause();
      final payload = QrService.encodeBinPayload('bin_11');
      final res = await controller.handleScannedCode(payload, binRepo);
      expect(res, isNull);

      controller.resume();
      final resResumed = await controller.handleScannedCode(payload, binRepo);
      expect(resResumed?.status, QrResolutionStatus.valid);
    });
  });
}
