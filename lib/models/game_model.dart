import 'package:equatable/equatable.dart';
import 'package:flutter_chess/models/user_model.dart';

class Game extends Equatable {
  Map<String, User> players;
  String status;
  String currentMove;
  String fen;

  Game(
      {required this.players,
      required this.status,
      required this.currentMove,
      required this.fen});

  factory Game.fromRTDB(Map<String, dynamic> data) {
    Map<String, User> players = {};

    print('from Game.fromRTDB: ${data['game'].toString()}');

    data['game']['players'].forEach((key, value) {
      players[key] = User.fromRTDB({
        'username': value['username'],
        'color': value['color'],
        'uuid': value['uuid'],
      });
    });
    //print('did this userFromRTDB work?: ${players.toString()}');

    return Game(
      players: players,
      status: data['game']['status'],
      currentMove: data['game']['current_move'],
      fen: data['game']['fen'],
    );

    //data[roomId]['game']
  }

  Map<String, dynamic> toJson() {
    return {
      'players': players.map((key, user) => MapEntry(key, user.toJson())),
      'status': status,
      'current_move': currentMove,
      'fen': fen,
    };
  }

  @override
  List<Object?> get props => [players, status, currentMove, fen];
}
