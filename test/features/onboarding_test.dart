import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reseller_inventory_app/core/services/onboarding_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingService Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('initial onboarding state is false', () async {
      final service = OnboardingService();
      final completed = await service.isOnboardingCompleted();
      expect(completed, isFalse);
    });

    test('completing onboarding sets completed flag', () async {
      final service = OnboardingService();
      await service.completeOnboarding(
        storageType: 'Garage',
        inventorySize: '100-500',
      );

      final completed = await service.isOnboardingCompleted();
      expect(completed, isTrue);
    });

    test('resetting onboarding clears flag', () async {
      final service = OnboardingService();
      await service.completeOnboarding(
        storageType: 'Garage',
        inventorySize: '100-500',
      );

      await service.resetOnboarding();
      final completed = await service.isOnboardingCompleted();
      expect(completed, isFalse);
    });
  });
}
