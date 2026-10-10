import 'bin.dart';

abstract class BinRepository {
  Future<Bin?> getBin(String id);
  Future<Bin?> getBinByCode(String locationId, String code);
  Future<List<Bin>> getBinsForLocation(String locationId,
      {bool includeArchived = false});
  Future<List<Bin>> getBinsForWorkspace(String workspaceId,
      {bool includeArchived = false});
  Future<List<Bin>> searchBins(String workspaceId, String query,
      {bool includeArchived = false});
  Future<int> getItemCountForBin(String binId);
  Future<bool> isBinCodeAvailable(String locationId, String code,
      {String? excludeBinId});
  Future<void> saveBin(Bin bin);
  Future<void> archiveBin(String id);
  Future<void> deleteBin(String id);
}
