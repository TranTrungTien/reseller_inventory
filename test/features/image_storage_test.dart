import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:reseller_inventory_app/core/storage/image_storage_service.dart';

void main() {
  group('LocalImageStorageService Tests', () {
    late Directory tempDir;
    late LocalImageStorageService storageService;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('binly_img_test_');
      storageService = LocalImageStorageService(tempDir.path);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('saves photo to persistent item directory', () async {
      final sourceFile = File('${tempDir.path}/source.jpg');
      await sourceFile.writeAsString('fake_image_content');

      final result =
          await storageService.processAndSavePhoto(sourceFile, 'item_99');

      expect(await storageService.imageExists(result.localPath), isTrue);
      expect(result.localPath, contains('item_99'));
      if (result.thumbnailPath != null) {
        expect(await storageService.imageExists(result.thumbnailPath!), isTrue);
      }
    });

    test('deletes photo files cleanly', () async {
      final sourceFile = File('${tempDir.path}/source.jpg');
      await sourceFile.writeAsString('fake_image_content');

      final result =
          await storageService.processAndSavePhoto(sourceFile, 'item_99');

      final deleted = await storageService.deletePhotoFiles(
        localPath: result.localPath,
        thumbnailPath: result.thumbnailPath,
      );

      expect(deleted, isTrue);
      expect(await storageService.imageExists(result.localPath), isFalse);
    });
  });
}
