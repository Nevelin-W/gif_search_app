import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/screens/gif_search.dart';

void main() {
  testWidgets('displays a message when no gifs are available',
      (WidgetTester tester) async {
    // Arrange
    final testWidget = MaterialApp(
      home: GifSearchScreen(
        gifs: const [],
        searchController: TextEditingController(),
        loadMoreGifs: () {},
        searchGifs: () {},
        isLoading: false,
        isInitialLoad: false,
        errorMessage: null,
      ),
    );

    // Act
    await tester.pumpWidget(testWidget);

    // Assert
    expect(find.text('Try searching for something!'), findsOneWidget);
  });
}
