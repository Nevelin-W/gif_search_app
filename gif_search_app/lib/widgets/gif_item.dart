import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/favorites.dart';
//screens
import 'package:gif_search_app/screens/gif_item_details.dart';

class GifItem extends ConsumerWidget {
  const GifItem({
    required this.gif,
    super.key,
  });

  final dynamic gif;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.watch(favoritesNotifierProvider.notifier);
    final isFavorite = ref.watch(favoritesNotifierProvider).contains(gif);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 3.0, right: 3.0),
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.transparent,
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                ),
                onPressed: () {
                  if (isFavorite) {
                    favoritesNotifier.removeFavorite(gif);
                  } else {
                    favoritesNotifier.addFavorite(gif);
                  }
                },
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GifItemDetailsScreen(gif: gif),
              ),
            );
          },
          child: Image.network(
            gif['images']['fixed_height']['url'],
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                    strokeWidth: 2.0,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
