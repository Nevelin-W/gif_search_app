import 'package:flutter/material.dart';
//widgets
import 'gif_item.dart';
//models
import 'package:gif_search_app/models/gif.dart';

class Gifs extends StatelessWidget {
  const Gifs({
    super.key,
    required this.gifs,
    required this.fetchGifs,
  });

  final List<Gif> gifs;
  final Function fetchGifs;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent) {
          fetchGifs();
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: gifs.length,
              itemBuilder: (context, index) {
                return GifItem(
                  gif: gifs[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
