import 'package:flutter/material.dart';

class GifItem extends StatelessWidget {
  final dynamic gif;

  const GifItem({
    required this.gif,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
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
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
      ),
    );
  }
}
