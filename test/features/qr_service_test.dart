import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:reseller_inventory_app/core/database/app_database.dart';
import 'package:reseller_inventory_app/core/qr/qr_service.dart';
import 'package:reseller_inventory_app/features/bins/data/bin_repository_impl.dart';
import 'package:reseller_inventory_app/features/bins/domain/bin.dart';

void main() {
  group('QrService Payload & Resolution Tests', () {
    test('encodeBinPayload generates correct opaque format', () {
      final payload = QrService.encodeBinPayload('bin_123');
      expect(payload, 'binly:bin:bin_123');
    });

    test('parsePayload correctly identifies bin QR', () {
      final res = QrService.parsePayload('binly:bin:bin_abc');
      expect(res.isValid, isTrue);
      expect(res.entityType, 'bin');
      expect(res.entityId, 'bin_abc');
    });

    test('parsePayload handles invalid payload formats', () {
      expect(QrService.parsePayload('invalid_string').isValid, isFalse);
      expect(QrService.parsePayload('binly:bin:').isValid, isFalse);
      expect(QrService.parsePayload('http://example.com').isValid, isFalse);
    });

    group('QrResolution against database', () {
      late AppDatabase db;
      late BinRepositoryImpl binRepo;

      setUp(() {
        db = AppDatabase(NativeDatabase.memory());
        binRepo = BinRepositoryImpl(db);
      });

      tearDown(() async {
        await db.close();
      });

      test('resolves valid active bin QR', () async {
        final now = DateTime.now();
        final bin = Bin(
          id: 'bin_valid',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'A01',
          createdAt: now,
          updatedAt: now,
        );
        await binRepo.saveBin(bin);

        final resolution =
            await QrService.resolveBinQr('binly:bin:bin_valid', binRepo);
        expect(resolution.status, QrResolutionStatus.valid);
        expect(resolution.bin?.code, 'A01');
      });

      test('resolves invalid format', () async {
        final resolution = await QrService.resolveBinQr('not_a_qr', binRepo);
        expect(resolution.status, QrResolutionStatus.invalidFormat);
      });

      test('resolves not found bin', () async {
        final resolution =
            await QrService.resolveBinQr('binly:bin:non_existent', binRepo);
        expect(resolution.status, QrResolutionStatus.notFound);
      });

      test('resolves archived bin', () async {
        final now = DateTime.now();
        final bin = Bin(
          id: 'bin_archived',
          workspaceId: 'ws_1',
          locationId: 'loc_1',
          code: 'A02',
          createdAt: now,
          updatedAt: now,
        );
        await binRepo.saveBin(bin);
        await binRepo.archiveBin('bin_archived');

        final resolution =
            await QrService.resolveBinQr('binly:bin:bin_archived', binRepo);
        expect(resolution.status, QrResolutionStatus.archived);
        expect(resolution.bin?.code, 'A02');
      });
    });
  });
}
