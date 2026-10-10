enum AppPermission {
  camera,
  storage,
}

enum PermissionStatus {
  notRequested,
  granted,
  denied,
  permanentlyDenied,
}

abstract class PermissionService {
  Future<PermissionStatus> checkPermission(AppPermission permission);
  Future<PermissionStatus> requestPermission(AppPermission permission);
  Future<bool> openAppSettings();
}

class DefaultPermissionService implements PermissionService {
  const DefaultPermissionService();

  @override
  Future<PermissionStatus> checkPermission(AppPermission permission) async {
    return PermissionStatus.granted;
  }

  @override
  Future<PermissionStatus> requestPermission(AppPermission permission) async {
    return PermissionStatus.granted;
  }

  @override
  Future<bool> openAppSettings() async {
    return true;
  }
}
