import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gif_search_app/models/gif.dart';

class GifState {
  GifState({
    required this.gifs,
    required this.page,
    required this.isLoading,
    required this.isInitialLoad,
    this.errorMessage,
  });

  final List<Gif> gifs;
  final int page;
  final bool isLoading;
  final bool isInitialLoad;
  final String? errorMessage;

  GifState copyWith({
    List<Gif>? gifs,
    int? page,
    bool? isLoading,
    bool? isInitialLoad,
    String? errorMessage,
  }) {
    return GifState(
      gifs: gifs ?? this.gifs,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      isInitialLoad: isInitialLoad ?? this.isInitialLoad,
      errorMessage: errorMessage ?? this.errorMessage,
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
          errorMessage: null,
        ));

  Future<void> fetchGifs(String searchTerm, {int limit = 20}) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      isInitialLoad: state.gifs.isEmpty,
      errorMessage: null,
    );

    try {
      final uri = Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=jBTAWdpDwFK53d1mwONTqytT9aWb0PgK&q=$searchTerm&limit=$limit&offset=${state.page * limit}',
      );
      final response = await http.get(uri);

      print(jsonDecode(response.body)['pagination']);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> rawGifs = data['data'];
        final List<Gif> newGifs =
            rawGifs.map((json) => Gif.fromJson(json)).toList();

        state = state.copyWith(
          gifs: [...state.gifs, ...newGifs],
          page: state.page + 1,
          isLoading: false,
          isInitialLoad: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load gifs',
        );
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred: ${error.toString()}',
      );
    }
  }

  void resetGifs() {
    state = state.copyWith(
      gifs: [],
      page: 0,
      isInitialLoad: true,
      errorMessage: null,
    );
  }
}

final gifProvider = StateNotifierProvider<GifNotifier, GifState>(
  (ref) {
    return GifNotifier();
  },
);
