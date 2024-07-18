import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, List<dynamic>>(
        (ref) => FavoritesNotifier());

class FavoritesNotifier extends StateNotifier<List<dynamic>> {
  FavoritesNotifier() : super([]);

  void addFavorite(dynamic gif) {
    state = [...state, gif];
  }

  void removeFavorite(dynamic gif) {
    state = state.where((favorite) => favorite != gif).toList();
  }

  bool isFavorite(dynamic gif) {
    return state.contains(gif);
  }
}
