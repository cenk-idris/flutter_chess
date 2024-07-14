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

  Future<PieceType?> handlePromotion(BuildContext context) {
    final navigator = Navigator.of(context);
    return showDialog<PieceType>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Promotion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Queen"),
                onTap: () => navigator.pop(PieceType.queen),
              ),
              ListTile(
                title: const Text("Rook"),
                onTap: () => navigator.pop(PieceType.rook),
              ),
              ListTile(
                title: const Text("Bishop"),
                onTap: () => navigator.pop(PieceType.bishop),
              ),
              ListTile(
                title: const Text("Knight"),
                onTap: () => navigator.pop(PieceType.knight),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGameEndDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the game screen
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
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
            return BlocConsumer<RoomCubit, RoomState>(
              listener: (context, roomState) {
                // Implement dialog logic for end game
                if (roomState is GameLoaded) {
                  final game = roomState.room.game!;
                  if (game.isCheckmate || game.isDraw) {
                    String result = '';
                    if (game.isCheckmate) {
                      result =
                          '${game.winner?.username ?? 'Unknown'} wins by checkmate!';
                    } else if (game.isDraw) {
                      result = 'The game is a draw!';
                    }
                    _showGameEndDialog(result);
                  }
                  final myColor = game.players.entries
                      .firstWhere((entry) => entry.value.uuid == user.uuid)
                      .value
                      .color;
                  if (myColor == game.currentMove) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('CHOP CHOP, YOUR TURN!')),
                    );
                  }
                }
              },
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
                        //Text('Current fen: ${game.fen}'),
                        Text('Current turn: ${game.currentMove}'),
                        if (game.isCheckmate)
                          Text('CHECKMATE - WINNER : ${game.winner?.username}')
                        else if (game.isDraw)
                          Text('DRAW'),

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
                            return PieceType.queen;
                          },
                          onPromotionCommited: ({
                            required ShortMove moveDone,
                            required PieceType pieceType,
                          }) {
                            print('promotion committed');
                            moveDone.promotion = pieceType;
                            context
                                .read<RoomCubit>()
                                .tryMakingMove(updatedRoom, moveDone);
                          },
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
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('RoomError ${roomState.toString()}'),
                      CircularProgressIndicator(),
                    ],
                  ));
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
