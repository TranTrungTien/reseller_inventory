// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Binly';

  @override
  String get todayTab => 'Today';

  @override
  String get inventoryTab => 'Inventory';

  @override
  String get scanTab => 'Scan';

  @override
  String get binsTab => 'Bins';

  @override
  String get moreTab => 'More';

  @override
  String get searchHint => 'Find an item, SKU or bin';

  @override
  String get createBin => 'Create bin';

  @override
  String get noBins => 'No bins yet.\nTry A01 for your first bin.';

  @override
  String get noItems =>
      'No items yet.\nUse Turbo Intake to add your first item.';
}
