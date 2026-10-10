import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const String _keyCompleted = 'onboarding_completed';
  static const String _keyStorageType = 'onboarding_storage_type';
  static const String _keyInventorySize = 'onboarding_inventory_size';

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyCompleted) ?? false;
  }

  Future<void> completeOnboarding({
    required String storageType,
    required String inventorySize,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStorageType, storageType);
    await prefs.setString(_keyInventorySize, inventorySize);
    await prefs.setBool(_keyCompleted, true);
  }

  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCompleted);
    await prefs.remove(_keyStorageType);
    await prefs.remove(_keyInventorySize);
  }
}
