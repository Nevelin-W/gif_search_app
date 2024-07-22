import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the files
import 'package:gif_search_app/models/gif.dart';
import 'package:gif_search_app/providers/favorites.dart';

void main() {
  group('FavoritesNotifier', () {
    late FavoritesNotifier favoritesNotifier;

    setUp(() {
      favoritesNotifier = FavoritesNotifier();
    });

    test('initial state is empty', () {
      expect(favoritesNotifier.state, []);
    });

    test('addFavorite adds a gif to the state', () {
      final gif = Gif(id: '1', url: 'url1', title: 'title1');

      favoritesNotifier.addFavorite(gif);

      expect(favoritesNotifier.state, [gif]);
    });

    test('removeFavorite removes a gif from the state', () {
      final gif = Gif(id: '1', url: 'url1', title: 'title1');

      favoritesNotifier.addFavorite(gif);
      favoritesNotifier.removeFavorite(gif);

      expect(favoritesNotifier.state, []);
    });

    test('isFavorite returns true for a favorite gif', () {
      final gif = Gif(id: '1', url: 'url1', title: 'title1');

      favoritesNotifier.addFavorite(gif);

      expect(favoritesNotifier.isFavorite(gif), true);
    });

    test('isFavorite returns false for a non-favorite gif', () {
      final gif = Gif(id: '1', url: 'url1', title: 'title1');

      expect(favoritesNotifier.isFavorite(gif), false);
    });

    test('addFavorite does not add the same gif twice', () {
      final gif = Gif(id: '1', url: 'url1', title: 'title1');

      favoritesNotifier.addFavorite(gif);
      favoritesNotifier.addFavorite(gif);

      expect(favoritesNotifier.state, [gif]);
    });
  });
}
