import 'package:flutter/material.dart';
//dependencies
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/theme.dart';
//screens
import 'package:gif_search_app/screens/gif_search.dart';
import 'package:gif_search_app/screens/favorites.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0; // Initially set to Gif Search screen
  TextEditingController searchController = TextEditingController();
  List<dynamic> gifs = [];
  String searchTerm = 'cat';
  int page = 0;
  int limit = 20;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _startingGifs();
  }

  void _startingGifs() {
    _fetchGifs(searchTerm, page, limit).then((result) {
      setState(() {
        gifs = result;
        page++;
      });
    });
  }

  void _searchGifs() {
    setState(() {
      gifs = [];
      page = 0;
    });
    _fetchGifs(searchController.text, page++, limit).then((result) {
      setState(() {
        gifs = result;
      });
    });
  }

  Future<List<dynamic>> _fetchGifs(
    String searchTerm,
    int page,
    int limit,
  ) async {
    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=jBTAWdpDwFK53d1mwONTqytT9aWb0PgK&q=$searchTerm&limit=$limit&offset=${page * limit}'));
    print(jsonDecode(response.body)['pagination']);
    print(page);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load gifs');
    }
  }

  void _loadMoreGifs() {
    _fetchGifs(searchTerm, page, limit).then((result) {
      setState(() {
        gifs.addAll(result);
        page++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Gif Search';
    Widget activePage = GifSearchScreen(
      gifs: gifs,
      searchController: searchController,
      loadMoreGifs: _loadMoreGifs,
      searchGifs: _searchGifs,
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
                icon: const Icon(Icons.lightbulb_outline_rounded),
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
                  child: SearchBar(
                    controller: searchController,
                    hintText: 'Search',
                    onChanged: (value) {
                      searchTerm = value;
                      _searchGifs();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimaryFixed,
        showUnselectedLabels: false,
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
    );
  }
}
