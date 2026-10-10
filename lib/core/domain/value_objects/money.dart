import 'package:intl/intl.dart';

class Money {
  const Money.fromMinorUnits(this.amountInMinorUnits,
      [this.currencyCode = 'USD']);

  factory Money.fromMajorUnits(num amount, [String currencyCode = 'USD']) {
    final minor = (amount * 100).round();
    return Money.fromMinorUnits(minor, currencyCode);
  }

  factory Money.zero([String currencyCode = 'USD']) {
    return Money.fromMinorUnits(0, currencyCode);
  }

  final int amountInMinorUnits;
  final String currencyCode;

  double get amountInMajorUnits => amountInMinorUnits / 100.0;

  Money operator +(Money other) {
    _ensureSameCurrency(other);
    return Money.fromMinorUnits(
        amountInMinorUnits + other.amountInMinorUnits, currencyCode);
  }

  Money operator -(Money other) {
    _ensureSameCurrency(other);
    return Money.fromMinorUnits(
        amountInMinorUnits - other.amountInMinorUnits, currencyCode);
  }

  Money operator *(num multiplier) {
    return Money.fromMinorUnits(
        (amountInMinorUnits * multiplier).round(), currencyCode);
  }

  bool operator >(Money other) {
    _ensureSameCurrency(other);
    return amountInMinorUnits > other.amountInMinorUnits;
  }

  bool operator <(Money other) {
    _ensureSameCurrency(other);
    return amountInMinorUnits < other.amountInMinorUnits;
  }

  bool operator >=(Money other) {
    _ensureSameCurrency(other);
    return amountInMinorUnits >= other.amountInMinorUnits;
  }

  bool operator <=(Money other) {
    _ensureSameCurrency(other);
    return amountInMinorUnits <= other.amountInMinorUnits;
  }

  void _ensureSameCurrency(Money other) {
    if (currencyCode.toUpperCase() != other.currencyCode.toUpperCase()) {
      throw ArgumentError(
          'Cannot operate on different currencies: $currencyCode vs ${other.currencyCode}');
    }
  }

  String format([String? locale]) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: _getSymbol(currencyCode),
    );
    return formatter.format(amountInMajorUnits);
  }

  static String _getSymbol(String code) {
    switch (code.toUpperCase()) {
      case 'USD':
      case 'CAD':
      case 'AUD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      default:
        return '$code ';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money &&
          runtimeType == other.runtimeType &&
          amountInMinorUnits == other.amountInMinorUnits &&
          currencyCode.toUpperCase() == other.currencyCode.toUpperCase();

  @override
  int get hashCode =>
      amountInMinorUnits.hashCode ^ currencyCode.toUpperCase().hashCode;

  @override
  String toString() => '$currencyCode ${amountInMajorUnits.toStringAsFixed(2)}';
}
