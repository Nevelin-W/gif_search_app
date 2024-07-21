import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/theme.dart';

class TabsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TabsAppBar({
    super.key,
    required this.title,
    required this.searchController,
    required this.onSearchChanged,
    this.isSearchVisible = true,
  });
  final String title;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final bool isSearchVisible;

  @override
  Size get preferredSize => const Size.fromHeight(105);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeNotifierProvider.notifier
        .select((themeNotifier) => themeNotifier.isLightTheme));
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 10,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(shadows: [
            Shadow(
              blurRadius: 2,
              offset: const Offset(0.5, 1),
              color: Theme.of(context).colorScheme.shadow,
            )
          ], isLightTheme ? Icons.lightbulb : Icons.lightbulb_outline_rounded),
          onPressed: () {
            ref.read(themeNotifierProvider.notifier).toggleTheme();
          },
        ),
      ],
      bottom: isSearchVisible
          ? PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 33,
                  child: SearchBar(
                    controller: searchController,
                    hintText: 'Search',
                    onChanged: onSearchChanged,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
