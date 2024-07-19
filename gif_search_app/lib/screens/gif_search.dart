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
  });
  final List<dynamic> gifs;
  final TextEditingController searchController;
  final VoidCallback loadMoreGifs;
  final VoidCallback searchGifs;

  @override
  Widget build(BuildContext context) {
    return gifs.isEmpty
        ? Center(
            heightFactor: 30,
            child: Text(
              'Try searching for something!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          )
        : Gifs(
            gifs: gifs,
            fetchGifs: loadMoreGifs,
          );
  }
}
