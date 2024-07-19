import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/favorites.dart';
//widgets
import 'package:gif_search_app/widgets/container_decoration.dart';

class GifItemDetailsScreen extends ConsumerWidget {
  const GifItemDetailsScreen({super.key, required this.gif});
  final dynamic gif;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.watch(favoritesNotifierProvider.notifier);
    final isFavorite = ref.watch(favoritesNotifierProvider).contains(gif);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gif['title'],
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 10,
        centerTitle: true,
        actions: [
          IconButton(
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
        ],
      ),
      body: DecoratedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                gif['images']['fixed_height']['url'],
                fit: BoxFit.fitWidth,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Download')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
