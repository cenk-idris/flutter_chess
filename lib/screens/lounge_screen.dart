import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';

import '../blocs/lounge_cubit/lounge_cubit.dart';
import '../models/room_model.dart';

class LoungeScreen extends StatelessWidget {
  const LoungeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<LoungeCubit, List<Room>>(
          builder: (context, lounge) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Lounge'),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ...lounge.map((room) {
                        return Card(
                          child: ListTile(
                            title: Text('Room: ${room.roomName}'),
                            subtitle: Text('Host name: ${room.owner.username}'),
                          ),
                        );
                      })
                    ],
                  )),
            );
          },
        );
      },
    );
  }
}