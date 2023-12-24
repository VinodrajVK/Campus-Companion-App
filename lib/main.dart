import 'package:flutter/material.dart';
import 'package:Campus_Companion/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Companion',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 245, 5, 233)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
