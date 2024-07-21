import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/gifs.dart';
//screens
import 'package:gif_search_app/screens/gif_search.dart';
import 'package:gif_search_app/screens/favorites.dart';
//widgets
import 'package:gif_search_app/widgets/tabs_index.dart';
//models
import 'package:gif_search_app/models/gif.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  TextEditingController searchController = TextEditingController();
  List<Gif> gifs = [];
  String searchTerm = 'cat';

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
    super.dispose();
  }

  void _onSearchChanged(String value) {
    ref.read(gifProvider.notifier).onSearchChanged(value);
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final gifs = ref.watch(gifProvider.select((state) => state.gifs));
    final isLoading = ref.watch(gifProvider.select((state) => state.isLoading));
    final isInitialLoad =
        ref.watch(gifProvider.select((state) => state.isInitialLoad));
    final errorMessage =
        ref.watch(gifProvider.select((state) => state.errorMessage));

    var activePageTitle = 'Gif Search';
    Widget activePage = GifSearchScreen(
      gifs: gifs,
      searchController: searchController,
      loadMoreGifs: () {
        ref.read(gifProvider.notifier).fetchGifs(searchTerm);
      },
      searchGifs: _searchGifs,
      isLoading: isLoading,
      isInitialLoad: isInitialLoad,
      errorMessage: errorMessage,
    );

    if (_selectedIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = const FavoritesScreen();
    }

    return Scaffold(
      appBar: TabsAppBar(
        title: activePageTitle,
        searchController: searchController,
        onSearchChanged: _onSearchChanged,
        isSearchVisible: _selectedIndex == 0,
      ),
      body: isLandscape
          ? Row(
              children: [
                buildVerticalNavBar(context, _selectedIndex, _onItemTapped),
                Expanded(child: DecoratedContainer(child: activePage)),
              ],
            )
          : DecoratedContainer(child: activePage),
      bottomNavigationBar: isLandscape
          ? null
          : buildBottomNavigationBar(context, _selectedIndex, _onItemTapped),
      floatingActionButton: const ErrorFAB(),
    );
  }
}
