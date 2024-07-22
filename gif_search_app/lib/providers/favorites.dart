import 'package:flutter_riverpod/flutter_riverpod.dart';
//models
import 'package:gif_search_app/models/gif.dart';

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, List<Gif>>(
        (ref) => FavoritesNotifier());

class FavoritesNotifier extends StateNotifier<List<Gif>> {
  FavoritesNotifier() : super([]);

  void addFavorite(Gif gif) {
    if (!state.contains(gif)) {
      state = [...state, gif];
    }
  }

  void removeFavorite(Gif gif) {
    state = state.where((favorite) => favorite.id != gif.id).toList();
  }

  bool isFavorite(Gif gif) {
    return state.contains(gif);
  }
}
