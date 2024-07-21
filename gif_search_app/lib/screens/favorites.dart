import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/favorites.dart';
//widgets
import 'package:gif_search_app/widgets/gif_item.dart';
import 'package:gif_search_app/widgets/container_decoration.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNotifierProvider);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final crossAxisCount = isLandscape ? 3 : 2;

    return Scaffold(
      body: DecoratedContainer(
        child: favorites.isEmpty
            ? Center(
                heightFactor: 30,
                child: Text(
                  'No favorites yet!',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return GifItem(gif: favorites[index]);
                },
              ),
      ),
    );
  }
}
