import 'package:flutter/material.dart';

class ChessApp extends StatelessWidget {
  ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chess',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
      ),
      home: Placeholder(),
    );
  }
}
