//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
//models
import 'package:gif_search_app/models/gif.dart';
//providers
import 'package:gif_search_app/providers/http.dart';

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
  GifNotifier(this._client)
      : super(GifState(
          gifs: [],
          page: 0,
          isLoading: false,
          isInitialLoad: true,
          errorMessage: null,
        ));

  final http.Client _client;
  Timer? _debounce;

  static const Map<int, String> _statusCodeMessages = {
    400: 'Bad request. Please try again.',
    401: 'Unauthorized. Please check your API key.',
    403: 'Forbidden. You do not have permission to access this resource.',
    404: 'Not found. The requested resource could not be found.',
    500: 'Internal server error. Please try again later.',
    502: 'Bad gateway. The server received an invalid response.',
    503: 'Service unavailable. Please try again later.',
    504: 'Gateway timeout. Please try again later.',
  };

  String _getErrorMessage(int statusCode) {
    return _statusCodeMessages[statusCode] ??
        'An unexpected error occurred. Please try again.';
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      resetGifs();
      fetchGifs(value);
    });
  }

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
      final response = await _client.get(uri);

      print(jsonDecode(response.body)['pagination']);
      print(jsonDecode(response.body)['meta']['status']);

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
          errorMessage: _getErrorMessage(response.statusCode),
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

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final gifProvider = StateNotifierProvider<GifNotifier, GifState>(
  (ref) {
    final client = ref.read(httpClientProvider);
    return GifNotifier(client);
  },
);
