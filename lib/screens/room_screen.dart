import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Lounge'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Text('ListTileView'),
              )
            ],
          ),
        );
      },
    );
  }
}
