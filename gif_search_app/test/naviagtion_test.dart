import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gif_search_app/screens/tabs.dart';

void main() {
  testWidgets('Navigation between tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TabsScreen(),
        ),
      ),
    );

    // Initially on Gif Search screen
    expect(find.text('Gif Search'), findsOneWidget);
    expect(find.byType(SearchBar), findsOneWidget);

    // Tap on the Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    // Now on Favorites screen
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.byType(SearchBar), findsNothing);
  });
}
