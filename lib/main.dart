import 'package:flutter/material.dart';
import 'package:search_flights/src/screens/search_flight.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Flight Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF63AF23)),
      ),
      home: const SearchFlight(),
    );
  }
}
