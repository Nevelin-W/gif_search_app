import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/screens/gif_search.dart';

void main() {
  testWidgets('Displays CircularProgressIndicator during initial load',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: GifSearchScreen(
        gifs: const [],
        searchController: TextEditingController(),
        loadMoreGifs: () {},
        searchGifs: () {},
        isLoading: true,
        isInitialLoad: true,
        errorMessage: null,
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
