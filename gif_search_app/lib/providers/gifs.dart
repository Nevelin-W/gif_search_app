import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GifState {
  GifState({required this.gifs, required this.page, required this.isLoading});

  final List<dynamic> gifs;
  final int page;
  final bool isLoading;

  GifState copyWith({List<dynamic>? gifs, int? page, bool? isLoading}) {
    return GifState(
      gifs: gifs ?? this.gifs,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class GifNotifier extends StateNotifier<GifState> {
  GifNotifier() : super(GifState(gifs: [], page: 0, isLoading: false));

  Future<void> fetchGifs(String searchTerm, {int limit = 20}) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    final response = await http.get(Uri.parse(
      'https://api.giphy.com/v1/gifs/search?api_key=jBTAWdpDwFK53d1mwONTqytT9aWb0PgK&q=$searchTerm&limit=$limit&offset=${state.page * limit}',
    ));
    print(jsonDecode(response.body)['pagination']['count']);

    if (response.statusCode == 200) {
      final newGifs = jsonDecode(response.body)['data'];
      state = state.copyWith(
        gifs: [...state.gifs, ...newGifs],
        page: state.page + 1,
        isLoading: false,
      );
      
    } else {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load gifs');
    }
  }

  void resetGifs() {
    state = state.copyWith(gifs: [], page: 0);
  }
}

final gifProvider = StateNotifierProvider<GifNotifier, GifState>((ref) {
  return GifNotifier();
});
