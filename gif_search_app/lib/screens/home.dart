import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//widgets
import 'package:gif_search_app/widgets/gifs.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});
  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> gifs = [];
  String searchTerm = 'cat';
  int page = 0;
  int limit = 20;

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

    /* print(jsonDecode(response.body)['pagination']);
    print(page); */
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load gifs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: Text(
          'Gif Search',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
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
      body: gifs.isEmpty
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
              gifs: gifs,
              searchTerm: searchTerm,
              fetchGifs: _fetchGifs,
              limit: limit,
              page: page,
            ),
    );
  }
}
