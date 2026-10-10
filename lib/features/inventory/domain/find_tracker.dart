class FindTracker {
  final Map<String, DateTime> _startTimes = {};

  void startFindIntent(String itemId) {
    _startTimes[itemId] = DateTime.now();
  }

  Duration completeFindIntent(String itemId) {
    final startTime = _startTimes.remove(itemId);
    if (startTime == null) {
      return Duration.zero;
    }
    return DateTime.now().difference(startTime);
  }
}
