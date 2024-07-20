import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
//providers
import 'package:gif_search_app/providers/theme.dart';
import 'package:gif_search_app/providers/gifs.dart';
//screens
import 'package:gif_search_app/screens/gif_search.dart';
import 'package:gif_search_app/screens/favorites.dart';
//widgets
import 'package:gif_search_app/widgets/container_decoration.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  TextEditingController searchController = TextEditingController();
  List<dynamic> gifs = [];
  String searchTerm = 'cat';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gifProvider.notifier).fetchGifs(searchTerm);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    searchTerm = value;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchGifs();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _searchGifs() {
    setState(() {
      ref.read(gifProvider.notifier).resetGifs();
      ref.read(gifProvider.notifier).fetchGifs(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = ref.watch(themeNotifierProvider.notifier
        .select((themeNotifier) => themeNotifier.isLightTheme));
    final gifState = ref.watch(gifProvider);
    var activePageTitle = 'Gif Search';
    Widget activePage = GifSearchScreen(
      gifs: gifState.gifs,
      searchController: searchController,
      loadMoreGifs: () {
        ref.read(gifProvider.notifier).fetchGifs(searchTerm);
      },
      searchGifs: _searchGifs,
      isLoading: gifState.isLoading,
      isInitialLoad: gifState.isInitialLoad,
      errorMessage: gifState.errorMessage,
    );

    if (_selectedIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = const FavoritesScreen();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            activePageTitle,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 10,
          centerTitle: true,
          actions: [
            Consumer(
              builder: (context, ref, _) {
                return IconButton(
                  icon: Icon(isLightTheme
                      ? Icons.lightbulb
                      : Icons.lightbulb_outline_rounded),
                  onPressed: () {
                    ref.read(themeNotifierProvider.notifier).toggleTheme();
                  },
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45.0,
                    child: _selectedIndex == 0
                        ? SearchBar(
                            controller: searchController,
                            hintText: 'Search',
                            onChanged: _onSearchChanged,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: DecoratedContainer(child: activePage),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          showUnselectedLabels: true,
          showSelectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: gifState.errorMessage != null
            ? FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(gifState.errorMessage!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer)),
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                    ),
                  );
                },
                label: Text(
                  'Show Error',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                icon: const Icon(
                  Icons.error,
                ),
              )
            : null);
  }
}
