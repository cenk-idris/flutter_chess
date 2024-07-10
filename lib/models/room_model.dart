import 'package:flutter/material.dart';
import 'package:flutter_chess/models/user_model.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:uuid/uuid.dart';

class Room {
  final User owner;
  final String roomName;
  final String roomId;
  final User? guest;
  //Game? game;
  final DatabaseService _databaseService = DatabaseService();

  Room({
    required this.owner,
    required this.roomName,
    required this.roomId,
    this.guest,
  });

  factory Room.fromRTDB(Map<String, dynamic> data) {
    User user = User(data['owner']['username'], Uuid().v4());
    user.uuid = data['owner']['uuid'];
    return Room(
      owner: user,
      roomName: data['room_name'],
      roomId: data['room_id'],
    );
  }
}
