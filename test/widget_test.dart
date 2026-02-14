// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:caffely/main.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Testing with hasSeenOnboarding: true to show WelcomeScreen
    await tester.pumpWidget(const MyApp(hasSeenOnboarding: true));

    // Verify that the Welcome Screen is shown
    expect(find.text('Caffely'), findsOneWidget);
    expect(find.text("Let's dive in into your account!"), findsOneWidget);
  });
}
