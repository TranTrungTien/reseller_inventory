import '../../../core/domain/value_objects/enums.dart';

class ItemPhoto {
  const ItemPhoto({
    required this.id,
    required this.itemId,
    this.localPath,
    this.remoteUrl,
    this.position = 0,
    this.uploadStatus = PhotoUploadStatus.pending,
    required this.createdAt,
  });

  final String id;
  final String itemId;
  final String? localPath;
  final String? remoteUrl;
  final int position;
  final PhotoUploadStatus uploadStatus;
  final DateTime createdAt;

  ItemPhoto copyWith({
    String? id,
    String? itemId,
    String? localPath,
    String? remoteUrl,
    int? position,
    PhotoUploadStatus? uploadStatus,
    DateTime? createdAt,
  }) {
    return ItemPhoto(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      position: position ?? this.position,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
