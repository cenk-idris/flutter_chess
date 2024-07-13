import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chess_board/models/short_move.dart';
import 'package:simple_chess_board/simple_chess_board.dart';

import '../blocs/room_cubit/room_cubit.dart';
import '../blocs/user_cubit/user_cubit.dart';
import '../models/room_model.dart';

class GameScreen extends StatefulWidget {
  final Room room;

  const GameScreen({super.key, required this.room});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  RoomCubit? _roomCubit;

  @override
  void initState() {
    super.initState();
    _roomCubit = context.read<RoomCubit>();
    print('GameScreen Game listener: ${_roomCubit!.isGameListenerPaused}');
  }

  @override
  void dispose() {
    //_roomCubit!.cancelRoomGameUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Board'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserRegistered) {
            final user = userState.user;
            return BlocBuilder<RoomCubit, RoomState>(
              builder: (context, roomState) {
                if (roomState is GameLoaded) {
                  final updatedRoom = roomState.room;
                  final game = updatedRoom.game!;
                  final myColor = game.players.entries
                      .firstWhere((entry) => entry.value.uuid == user.uuid)
                      .value
                      .color;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Current fen: ${game.fen}'),
                        Text('Current turn: ${game.currentMove}'),
                        SizedBox(height: 20.0),
                        SimpleChessBoard(
                          fen: game.fen,
                          blackSideAtBottom: myColor == 'black',
                          whitePlayerType: myColor == 'white'
                              ? PlayerType.human
                              : PlayerType.computer,
                          blackPlayerType: myColor == 'black'
                              ? PlayerType.human
                              : PlayerType.computer,
                          onMove: ({required ShortMove move}) {
                            context
                                .read<RoomCubit>()
                                .tryMakingMove(updatedRoom, move);
                          },
                          onPromote: () async {
                            return null;
                          },
                          onPromotionCommited: ({
                            required ShortMove moveDone,
                            required PieceType pieceType,
                          }) {},
                          chessBoardColors: ChessBoardColors()
                            ..lightSquaresColor = Colors.blue.shade100
                            ..darkSquaresColor = Colors.blue.shade600
                            ..coordinatesZoneColor = Colors.blue
                            ..lastMoveArrowColor = Colors.cyan
                            ..startSquareColor = Colors.orange
                            ..endSquareColor = Colors.green
                            ..circularProgressBarColor = Colors.red
                            ..coordinatesColor = Colors.white,
                          showCoordinatesZone: true,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (userState is UserRegistrationError) {
            return Center(child: Text('User Error: ${userState.message}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
