import 'package:flutter/material.dart';
import 'package:flutter_chess/models/user_model.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:uuid/uuid.dart';

class Room {
  final User owner;
  final String roomName;
  final String roomId = Uuid().v4();
  final User? guest;
  //Game? game;
  final DatabaseService _databaseService = DatabaseService();

  Room({
    required this.owner,
    required this.roomName,
    this.guest,
  });
}
