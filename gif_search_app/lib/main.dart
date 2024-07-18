import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//screens

import 'screens/tabs.dart';

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
      ),
      home: const TabsScreen(),
    );
  }
}
