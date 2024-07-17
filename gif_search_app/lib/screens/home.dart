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
  List<dynamic> gifs = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    _startingGifs();
  }

  void _startingGifs() {
    _fetchGifs('cat').then((result) {
      setState(() {
        gifs = result;
      });
    });
  }

  Future<List<dynamic>> _fetchGifs(String searchTerm) async {
    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=jBTAWdpDwFK53d1mwONTqytT9aWb0PgK&q=$searchTerm&limit=20'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load gifs');
    }
  }

  void _searchGifs() {
    setState(() {
      gifs = [];
    });
    _fetchGifs(searchTerm).then((result) {
      setState(() {
        gifs = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 45.0,
                  child: SearchBar(
                    hintText: 'Search',
                    onChanged: (value) {
                      searchTerm = value;
                    },
                    onSubmitted: (value) {
                      searchTerm = value;
                      _searchGifs();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, size: 30.0),
                  onPressed: _searchGifs,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Gifs(
        gifs: gifs,
      ),
    );
  }
}
