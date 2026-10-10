class Device {
  const Device({
    required this.id,
    required this.workspaceId,
    required this.name,
    required this.platform,
    required this.lastSeenAt,
  });

  final String id;
  final String workspaceId;
  final String name;
  final String platform;
  final DateTime lastSeenAt;

  Device copyWith({
    String? id,
    String? workspaceId,
    String? name,
    String? platform,
    DateTime? lastSeenAt,
  }) {
    return Device(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      platform: platform ?? this.platform,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}
