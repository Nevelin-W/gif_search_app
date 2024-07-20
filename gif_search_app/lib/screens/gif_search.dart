import 'package:flutter/material.dart';
//widgets
import 'package:gif_search_app/widgets/gifs.dart';

class GifSearchScreen extends StatelessWidget {
  const GifSearchScreen({
    super.key,
    required this.gifs,
    required this.searchController,
    required this.loadMoreGifs,
    required this.searchGifs,
    required this.isLoading,
    required this.isInitialLoad,
    required this.errorMessage,
  });
  final List<dynamic> gifs;
  final TextEditingController searchController;
  final VoidCallback loadMoreGifs;
  final VoidCallback searchGifs;
  final bool isLoading;
  final bool isInitialLoad;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (isInitialLoad && isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    } else if (errorMessage != null) {
      return Center(
        heightFactor: 30,
        child: Text(
          'Something went wrong :(',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      );
    } else if (gifs.isEmpty) {
      return Center(
        heightFactor: 30,
        child: Text(
          'Try searching for something!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      );
    } else {
      return Gifs(
        gifs: gifs,
        fetchGifs: loadMoreGifs,
      );
    }
  }
}
