import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:gif_search_app/providers/gifs.dart';

void main() {
  group('GifNotifier Tests', () {
    late http.Client httpClient;

    setUp(() {
      httpClient = http.Client();
    });

    tearDown(() {
      httpClient.close();
    });

    test('fetchGifs should update state with fetched GIFs', () async {
      final notifier = GifNotifier(httpClient);
      const searchTerm = 'cats';

      await notifier.fetchGifs(searchTerm);

      expect(notifier.state.gifs.isNotEmpty, true);
      expect(notifier.state.errorMessage, isNull);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.isInitialLoad, false);
    });

    test('resetGifs should reset state', () {
      final notifier = GifNotifier(httpClient);

      notifier.resetGifs();

      expect(notifier.state.gifs.isEmpty, true);
      expect(notifier.state.page, 0);
      expect(notifier.state.errorMessage, isNull);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.isInitialLoad, true);
    });
  });
}
