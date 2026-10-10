import 'location.dart';

abstract class LocationRepository {
  Future<Location?> getLocation(String id);
  Future<List<Location>> getLocationsForWorkspace(String workspaceId,
      {bool includeArchived = false});
  Future<void> saveLocation(Location location);
  Future<void> archiveLocation(String id);
  Future<void> deleteLocation(String id);
}
