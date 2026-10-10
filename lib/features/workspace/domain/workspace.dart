class Workspace {
  const Workspace({
    required this.id,
    required this.name,
    this.code,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String? code;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Workspace copyWith({
    String? id,
    String? name,
    String? code,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workspace(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
