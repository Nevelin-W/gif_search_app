import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gif_search_app/screens/tabs.dart';

void main() {
  testWidgets('Initial state is correct', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TabsScreen(),
        ),
      ),
    );

    expect(find.text('Gif Search'), findsOneWidget);
    expect(find.byType(SearchBar), findsOneWidget);
  });
}
