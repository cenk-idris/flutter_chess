import 'package:flutter/material.dart';
import 'package:flutter_chess/screens/main_screen.dart';
import 'package:flutter_chess/screens/registration_screen.dart';

class ChessApp extends StatelessWidget {
  ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chess',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
      ),
      initialRoute: '/registration',
      routes: {
        '/registration': (context) => RegistrationScreen(),
        '/main-screen': (context) => MainScreen(),
      },
    );
  }
}
