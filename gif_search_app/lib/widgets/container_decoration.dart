import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer
          ],
        ),
      ),
      child: child,
    );
  }
}
