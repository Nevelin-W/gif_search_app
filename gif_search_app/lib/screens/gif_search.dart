import 'package:flutter/material.dart';
//widgets
import 'package:gif_search_app/widgets/gifs.dart';

class GifSearchScreen extends StatefulWidget {
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
  State<GifSearchScreen> createState() => _GifSearchScreenState();
}

class _GifSearchScreenState extends State<GifSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      body: widget.gifs.isEmpty
          ? Center(
              heightFactor: 20,
              child: Text(
                'Try searching for something!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            )
          : Gifs(
              gifs: widget.gifs,
              fetchGifs: widget.loadMoreGifs,
            ),
    );
  }
}
