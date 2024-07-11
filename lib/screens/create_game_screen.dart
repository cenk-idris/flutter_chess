import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_chess/screens/room_detail_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoomDetailScreen(
                                          room: roomState.room)));
                            } else if (roomState is RoomError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(roomState.message)),
                              );
                            }
                          },
                          builder: (context, roomState) {
                            if (roomState is RoomLoading) {
                              return ElevatedButton(
                                  onPressed: null,
                                  child: CircularProgressIndicator());
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                final userCubit = context.read<UserCubit>();
                                final User? user = userCubit.user;
                                final String roomName =
                                    _roomNameController.text.trim();
                                final RegExp roomNamePattern =
                                    RegExp(r'^[a-zA-Z0-9]+$');
                                if (user != null &&
                                    roomNamePattern.hasMatch(roomName)) {
                                  final Room room = Room(
                                    owner: user,
                                    roomName: roomName,
                                    roomId: Uuid().v4(),
                                  );
                                  context.read<RoomCubit>().createRoom(room);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Room name must contain only letters and numbers'),
                                    ),
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
