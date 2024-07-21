import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif_search_app/screens/tabs.dart';

void main() {
  testWidgets('SearchBar input triggers search function',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TabsScreen(),
        ),
      ),
    );

    expect(find.byType(SearchBar), findsOneWidget);

    await tester.enterText(find.byType(SearchBar), 'dog');
    await tester.pump();
  });
}
