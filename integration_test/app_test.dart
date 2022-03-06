import 'package:distributed/main.dart' as app;
import 'package:distributed/src/ui/screens/settings/settings.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('whole app', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
    });
    testWidgets('Settings button is present and triggers navigation',
        (WidgetTester tester) async {
      var mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: SettingsScreen(),
        ),
      );
      expect(find.byType(PrimaryButton), findsOneWidget);
      await tester.tap(find.byType(PrimaryButton)); 
      await tester.pumpAndSettle();

      // expect(find.byType(HomeScreen), findsOneWidget);

    });
  });
}
