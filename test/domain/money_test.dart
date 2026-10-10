import 'package:flutter_test/flutter_test.dart';
import 'package:reseller_inventory_app/core/domain/value_objects/money.dart';

void main() {
  group('Money Value Object', () {
    test('creates from minor units correctly', () {
      const money = Money.fromMinorUnits(1999, 'USD');
      expect(money.amountInMinorUnits, 1999);
      expect(money.amountInMajorUnits, 19.99);
      expect(money.currencyCode, 'USD');
    });

    test('creates from major units correctly', () {
      final money = Money.fromMajorUnits(24.50, 'USD');
      expect(money.amountInMinorUnits, 2450);
      expect(money.amountInMajorUnits, 24.50);
    });

    test('addition and subtraction work within same currency', () {
      final m1 = Money.fromMajorUnits(10.00, 'USD');
      final m2 = Money.fromMajorUnits(5.50, 'USD');

      final sum = m1 + m2;
      expect(sum.amountInMajorUnits, 15.50);

      final diff = m1 - m2;
      expect(diff.amountInMajorUnits, 4.50);
    });

    test('multiplication works correctly', () {
      final m = Money.fromMajorUnits(12.00, 'USD');
      final result = m * 1.5;
      expect(result.amountInMajorUnits, 18.00);
    });

    test('comparison operators work', () {
      final m1 = Money.fromMajorUnits(10.00, 'USD');
      final m2 = Money.fromMajorUnits(20.00, 'USD');

      expect(m1 < m2, isTrue);
      expect(m2 > m1, isTrue);
      expect(m1 == Money.fromMajorUnits(10.00, 'USD'), isTrue);
    });

    test('throws ArgumentError on different currencies', () {
      final usd = Money.fromMajorUnits(10.00, 'USD');
      final eur = Money.fromMajorUnits(10.00, 'EUR');

      expect(() => usd + eur, throwsArgumentError);
    });

    test('formats currency properly', () {
      final money = Money.fromMajorUnits(49.99, 'USD');
      final formatted = money.format('en_US');
      expect(formatted, contains('49.99'));
    });
  });
}
