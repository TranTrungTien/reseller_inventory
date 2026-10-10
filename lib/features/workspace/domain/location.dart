class Location {
  const Location({
    required this.id,
    required this.workspaceId,
    required this.name,
    this.code,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String workspaceId;
  final String name;
  final String? code;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  bool get isArchived => deletedAt != null;

  Location copyWith({
    String? id,
    String? workspaceId,
    String? name,
    String? code,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Location(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
