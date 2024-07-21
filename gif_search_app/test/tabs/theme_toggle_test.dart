import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif_search_app/screens/tabs.dart';

void main() {
  testWidgets('Toggle theme in AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TabsScreen(),
        ),
      ),
    );

    // Verify the initial theme icon
    expect(find.byIcon(Icons.lightbulb), findsOneWidget);

    // Tap on the theme toggle button
    await tester.tap(find.byIcon(Icons.lightbulb));
    await tester.pumpAndSettle();

    // Verify the theme icon has changed
    expect(find.byIcon(Icons.lightbulb_outline_rounded), findsOneWidget);
  });
}
