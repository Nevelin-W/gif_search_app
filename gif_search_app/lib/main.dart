import 'package:flutter/material.dart';
//dependencies
import 'package:flutter_riverpod/flutter_riverpod.dart';
//screens
import 'screens/tabs.dart';
//providers
import 'package:gif_search_app/providers/theme.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
