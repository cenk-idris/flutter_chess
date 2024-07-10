import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/room_cubit/room_cubit.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';

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
                FontAwesomeIcons.solidChessKnight,
                size: 100.0,
                color: Colors.blue,
              ),
              Column(
                children: [
                  TextField(
                    controller: _roomNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter room name',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocConsumer<RoomCubit, RoomState>(
                          listener: (context, roomState) {
                            if (roomState is RoomLoaded) {
                              Navigator.pushNamed(context, '/room-detail');
                            }
                          },
                          builder: (context, roomState) {
                            return ElevatedButton(
                              onPressed: () async {
                                final userCubit = context.read<UserCubit>();
                                final User? user = userCubit.user;
                                if (user != null) {
                                  final Room room = Room(
                                    owner: user,
                                    roomName: _roomNameController.text,
                                  );
                                }
                              },
                              child: Text('Create Room'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
