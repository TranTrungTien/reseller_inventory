import 'package:flutter/foundation.dart';

abstract class AnalyticsService {
  void logEvent(String name, [Map<String, dynamic>? parameters]);

  void logInventorySearch(String query, int resultCount);
  void logItemFound(String itemId, String? binId, Duration duration);
  void logItemNotFound(String itemId, String? binId);
  void logItemMarkedMissing(String itemId, String? binId);
  void logItemFoundAgain(String itemId, String? newBinId);
}

class ConsoleAnalyticsService implements AnalyticsService {
  const ConsoleAnalyticsService();

  @override
  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    debugPrint('[ANALYTICS] Event: $name | Params: $parameters');
  }

  @override
  void logInventorySearch(String query, int resultCount) {
    logEvent('inventory_search', {'query': query, 'result_count': resultCount});
  }

  @override
  void logItemFound(String itemId, String? binId, Duration duration) {
    logEvent('item_found', {
      'item_id': itemId,
      'bin_id': binId,
      'duration_ms': duration.inMilliseconds,
    });
  }

  @override
  void logItemNotFound(String itemId, String? binId) {
    logEvent('item_not_found', {'item_id': itemId, 'bin_id': binId});
  }

  @override
  void logItemMarkedMissing(String itemId, String? binId) {
    logEvent('item_marked_missing', {'item_id': itemId, 'bin_id': binId});
  }

  @override
  void logItemFoundAgain(String itemId, String? newBinId) {
    logEvent('item_found_again', {'item_id': itemId, 'new_bin_id': newBinId});
  }
}
