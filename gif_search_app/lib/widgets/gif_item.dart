import 'package:flutter/material.dart';

class GifItem extends StatelessWidget {
  final dynamic gif;

  const GifItem({
    required this.gif,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 3.0, right: 3.0),
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.transparent,
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons
                    .favorite_outline), // Use an appropriate icon for theme change
                onPressed: () {
                  // Implement theme change logic here
                  // You can toggle between dark and light themes
                },
              ),
            ),
          ),
        ),
        child: Image.network(
          gif['images']['fixed_height']['url'],
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                  strokeWidth: 2.0,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
