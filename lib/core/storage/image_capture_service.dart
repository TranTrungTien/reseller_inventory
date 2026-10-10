import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class ImageCaptureService {
  Future<File?> capturePhotoFromCamera();
  Future<File?> pickPhotoFromGallery();
}

class DefaultImageCaptureService implements ImageCaptureService {
  DefaultImageCaptureService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<File?> capturePhotoFromCamera() async {
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      return xFile != null ? File(xFile.path) : null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<File?> pickPhotoFromGallery() async {
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      return xFile != null ? File(xFile.path) : null;
    } catch (_) {
      return null;
    }
  }
}
