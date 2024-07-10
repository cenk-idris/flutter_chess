import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/room_cubit/room_cubit.dart';
import '../blocs/user_cubit/user_cubit.dart';
import '../models/room_model.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<RoomCubit, RoomState>(
          builder: (context, roomState) {
            Room? room;
            if (roomState is RoomLoaded) {
              room = roomState.room;
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Find your opponent'),
              ),
              body: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FontAwesomeIcons.chessBoard,
                      size: 100.0,
                      color: Colors.blue,
                    ),
                    Column(
                      children: [
                        Text(
                          'Host: ${room?.owner.username}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        room?.guest?.username != null
                            ? Text(
                                'Guest: ${room?.guest?.username}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Waiting opponent:   ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              ),
                      ],
                    ),
                    context.read<UserCubit>().user?.uuid == room?.owner.uuid
                        ? ElevatedButton(
                            onPressed: () {},
                            child: Text('Start Game'),
                          )
                        : Container()
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
