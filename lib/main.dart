import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/app.dart';
import 'package:flutter_chess/blocs/lounge_cubit/lounge_cubit.dart';
import 'package:flutter_chess/blocs/room_cubit/room_cubit.dart';
import 'package:flutter_chess/firebase_options.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => LoungeCubit()),
        BlocProvider(create: (context) => RoomCubit()),
      ],
      child: ChessApp(),
    ),
  );
}
