import 'package:flutter_chess/models/user_model.dart';

class Game {
  Map<String, User> players;
  String status;
  String currentMove;
  String fen;

  Game(
      {required this.players,
      required this.status,
      required this.currentMove,
      required this.fen});

  factory Game.fromRTDB(Map<String, dynamic> data, String roomId) {
    Map<String, User> players = {};

    print('from Game.fromRTDB: ${data[roomId]['game'].toString()}');

    data['players'].forEach((key, value) {
      players[key] = User.fromRTDB({
        'username': value['username'],
        'color': value['color'],
        'uuid': value['uuid'],
      });
    });

    return Game(
      players: players,
      status: data['status'],
      currentMove: data['board_state']['current_move'],
      fen: data['board_state']['fen'],
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
}
