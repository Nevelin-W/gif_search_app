import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//screens
import 'screens/home.dart';

/* final theme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 18, 89, 117),
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(),
  /* scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60), */
); */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 137, 215, 247),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().apply(),
        /* scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60), */
      ),
      home: const HomeSceen(),
    );
  }
}
