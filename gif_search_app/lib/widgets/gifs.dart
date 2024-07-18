import 'package:flutter/material.dart';
//widgets
import 'gif_item.dart';

class Gifs extends StatefulWidget {
  const Gifs({
    super.key,
    required this.gifs,
    required this.fetchGifs,
  });

  final List<dynamic> gifs;
  final Function fetchGifs;

  @override
  State<Gifs> createState() => _GifsState();
}

class _GifsState extends State<Gifs> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent) {
          widget.fetchGifs();
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
              itemCount: widget.gifs.length,
              itemBuilder: (context, index) {
                return GifItem(
                  gif: widget.gifs[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
