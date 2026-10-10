import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reseller_inventory_app/app/app.dart';

void main() {
  testWidgets('ResellerApp renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ResellerApp(),
      ),
    );

    expect(find.text('Binly'), findsNothing); // Title in app bar or theme
    expect(find.byType(ResellerApp), findsOneWidget);
  });
}
