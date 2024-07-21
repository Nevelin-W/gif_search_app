import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/providers/http.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif_search_app/screens/tabs.dart';
import 'package:gif_search_app/screens/gif_search.dart';
import 'package:gif_search_app/screens/favorites.dart';
import 'mocks.mocks.dart';

void main() {
  late MockClient mockClient;
  late ProviderContainer container;

  setUp(() {
    mockClient = MockClient();
    container = ProviderContainer(
      overrides: [
        httpClientProvider.overrideWithValue(mockClient),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  testWidgets('should display GifSearchScreen when the first tab is selected',
      (WidgetTester tester) async {
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response('{"data": [], "pagination": {}}', 200),
    );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: TabsScreen()),
      ),
    );

    // Verify that the GifSearchScreen is displayed
    expect(find.byType(GifSearchScreen), findsOneWidget);
    expect(find.byType(FavoritesScreen), findsNothing);
  });

  testWidgets('should display FavoritesScreen when the second tab is selected',
      (WidgetTester tester) async {
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response('{"data": [], "pagination": {}}', 200),
    );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: TabsScreen()),
      ),
    );

    // Tap on the second tab
    await tester.tap(find.byIcon(
        Icons.favorite)); // Adjust icon or method to navigate to the second tab
    await tester.pumpAndSettle();

    // Verify that the FavoritesScreen is displayed
    expect(find.byType(FavoritesScreen), findsOneWidget);
    expect(find.byType(GifSearchScreen), findsNothing);
  });
}
