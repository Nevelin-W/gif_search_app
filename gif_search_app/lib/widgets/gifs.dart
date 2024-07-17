import 'package:flutter/material.dart';
//widgets
import 'gif_item.dart';

class Gifs extends StatefulWidget {
  Gifs(
      {super.key,
      required this.gifs,
      required this.searchTerm,
      required this.fetchGifs,
      required this.page,
      required this.limit});

  final List<dynamic> gifs;
  final String searchTerm;
  final Function fetchGifs;
  final int limit;
  int page;

  

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
          widget
              .fetchGifs(widget.searchTerm, widget.page, widget.limit)
              .then((result) {
            setState(() {
              widget.gifs.addAll(result);
              widget.page++;
            });
          });
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
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
