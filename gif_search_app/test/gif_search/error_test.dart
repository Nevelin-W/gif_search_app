import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/screens/gif_search.dart';

void main() {
  testWidgets('displays error message when there is an error',
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
        errorMessage: 'Something went wrong',
      ),
    );

    // Act
    await tester.pumpWidget(testWidget);

    // Assert
    expect(find.text('Something went wrong :('), findsOneWidget);
  });
}
