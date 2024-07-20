import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GifState {
  GifState({
    required this.gifs,
    required this.page,
    required this.isLoading,
    required this.isInitialLoad,
  });

  final List<dynamic> gifs;
  final int page;
  final bool isLoading;
  final bool isInitialLoad;

  GifState copyWith(
      {List<dynamic>? gifs, int? page, bool? isLoading, bool? isInitialLoad}) {
    return GifState(
      gifs: gifs ?? this.gifs,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      isInitialLoad: isInitialLoad ?? this.isInitialLoad,
    );
  }
}

class GifNotifier extends StateNotifier<GifState> {
  GifNotifier()
      : super(GifState(
          gifs: [],
          page: 0,
          isLoading: false,
          isInitialLoad: true,
        ));

  Future<void> fetchGifs(String searchTerm, {int limit = 20}) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isInitialLoad: state.gifs.isEmpty);

    final response = await http.get(Uri.parse(
      'https://api.giphy.com/v1/gifs/search?api_key=jBTAWdpDwFK53d1mwONTqytT9aWb0PgK&q=$searchTerm&limit=$limit&offset=${state.page * limit}',
    ));
    print(jsonDecode(response.body)['pagination']);

    if (response.statusCode == 200) {
      final newGifs = jsonDecode(response.body)['data'];
      state = state.copyWith(
        gifs: [...state.gifs, ...newGifs],
        page: state.page + 1,
        isLoading: false,
        isInitialLoad: false,
      );
    } else {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load gifs');
    }
  }

  void resetGifs() {
    state = state.copyWith(gifs: [], page: 0, isInitialLoad: true);
  }
}

final gifProvider = StateNotifierProvider<GifNotifier, GifState>(
  (ref) {
    return GifNotifier();
  },
);
