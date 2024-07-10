import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateGameScreen extends StatelessWidget {
  CreateGameScreen({super.key});

  final TextEditingController _roomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create room'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.chessKnight,
                size: 60.0,
              ),
              TextField(
                controller: _roomNameController,
                decoration: InputDecoration(
                  hintText: 'Enter room name',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
