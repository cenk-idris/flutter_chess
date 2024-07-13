import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/room_cubit/room_cubit.dart';
import '../blocs/user_cubit/user_cubit.dart';
import '../models/room_model.dart';

class GameScreen extends StatelessWidget {
  final Room room;

  const GameScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Board'),
      ),
      body: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, roomState) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              return Center(
                child: Text(roomState.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
