class Bin {
  const Bin({
    required this.id,
    required this.workspaceId,
    required this.locationId,
    required this.code,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String workspaceId;
  final String locationId;
  final String code;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  bool get isArchived => deletedAt != null;

  Bin copyWith({
    String? id,
    String? workspaceId,
    String? locationId,
    String? code,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Bin(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      locationId: locationId ?? this.locationId,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
