import 'package:flutter/material.dart';
import 'package:flutter_chess/screens/create_game_screen.dart';
import 'package:flutter_chess/screens/invites_screen.dart';
import 'package:flutter_chess/screens/room_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people), text: 'Lounge'),
              Tab(icon: Icon(Icons.add), text: 'Create game'),
              Tab(icon: Icon(Icons.local_post_office), text: 'Invites'),
            ],
          ),
          body: TabBarView(
            children: [RoomScreen(), CreateGameScreen(), InvitesScreen()],
          )),
    );
  }
}
