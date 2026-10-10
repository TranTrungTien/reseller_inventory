import 'dart:io';
import 'package:uuid/uuid.dart';

class ProcessedImageResult {
  const ProcessedImageResult({
    required this.localPath,
    this.thumbnailPath,
  });

  final String localPath;
  final String? thumbnailPath;
}

abstract class ImageStorageService {
  Future<ProcessedImageResult> processAndSavePhoto(
      File sourceFile, String itemId);
  Future<bool> deletePhotoFiles({String? localPath, String? thumbnailPath});
  Future<bool> imageExists(String localPath);
}

class LocalImageStorageService implements ImageStorageService {
  const LocalImageStorageService(this.baseDirectoryPath);

  final String baseDirectoryPath;

  @override
  Future<ProcessedImageResult> processAndSavePhoto(
      File sourceFile, String itemId) async {
    final itemDir = Directory('$baseDirectoryPath/$itemId');
    if (!await itemDir.exists()) {
      await itemDir.create(recursive: true);
    }

    final photoId = const Uuid().v4();
    final fileName = 'img_$photoId.jpg';
    final thumbFileName = 'thumb_$photoId.jpg';

    final targetPath = '${itemDir.path}/$fileName';
    final thumbPath = '${itemDir.path}/$thumbFileName';

    // Asynchronously copy file into persistent item directory
    await sourceFile.copy(targetPath);
    // Create thumbnail placeholder or copy for fast rendering
    await sourceFile.copy(thumbPath);

    return ProcessedImageResult(
      localPath: targetPath,
      thumbnailPath: thumbPath,
    );
  }

  @override
  Future<bool> deletePhotoFiles(
      {String? localPath, String? thumbnailPath}) async {
    bool deletedAny = false;
    if (localPath != null) {
      final mainFile = File(localPath);
      if (await mainFile.exists()) {
        await mainFile.delete();
        deletedAny = true;
      }
    }
    if (thumbnailPath != null) {
      final thumbFile = File(thumbnailPath);
      if (await thumbFile.exists()) {
        await thumbFile.delete();
        deletedAny = true;
      }
    }
    return deletedAny;
  }

  @override
  Future<bool> imageExists(String localPath) async {
    return File(localPath).exists();
  }
}
