import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif_search_app/screens/tabs.dart';

void main() {
  testWidgets('Initial state of TabsScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TabsScreen(),
        ),
      ),
    );

    // Verify that the default page is GifSearchScreen
    expect(find.text('Gif Search'), findsOneWidget);

    // Verify that the SearchBar is present when on the first tab
    expect(find.byType(SearchBar), findsOneWidget);
  });
}
