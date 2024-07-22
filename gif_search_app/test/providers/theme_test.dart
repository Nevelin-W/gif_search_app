// test/providers/theme_notifier_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/providers/theme.dart';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure bindings are initialized

  group('ThemeNotifier Tests', () {
    late ProviderContainer container;
    late ThemeNotifier themeNotifier;

    setUp(() {
      container = ProviderContainer();
      themeNotifier = container.read(themeNotifierProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state is light theme', () {
      expect(themeNotifier.isLightTheme, true);
      expect(
          container.read(themeNotifierProvider).brightness, Brightness.light);
    });

    test('Toggle theme changes to dark theme', () {
      themeNotifier.toggleTheme();
      expect(themeNotifier.isLightTheme, false);
      expect(container.read(themeNotifierProvider).brightness, Brightness.dark);
    });

    test('Toggle theme back to light theme', () {
      themeNotifier.toggleTheme(); // To dark theme
      themeNotifier.toggleTheme(); // Back to light theme
      expect(themeNotifier.isLightTheme, true);
      expect(
          container.read(themeNotifierProvider).brightness, Brightness.light);
    });
  });
}
