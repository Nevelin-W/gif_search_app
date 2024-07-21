import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//providers
import 'package:gif_search_app/providers/gifs.dart';

class ErrorFAB extends ConsumerWidget {
  const ErrorFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage =
        ref.watch(gifProvider.select((state) => state.errorMessage));

    return errorMessage != null
        ? FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    errorMessage,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
              );
            },
            label: Text(
              'Show Error',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            icon: const Icon(
              Icons.error,
            ),
          )
        : const SizedBox.shrink();
  }
}
