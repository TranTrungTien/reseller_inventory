import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../domain/value_objects/money.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en', 'US'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String formatCurrency(Money money) {
    return money.format(locale.toString());
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMd(locale.toString()).format(date);
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd(locale.toString()).add_jm().format(dateTime);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
