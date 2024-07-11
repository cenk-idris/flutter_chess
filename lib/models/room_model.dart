import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/models/user_model.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:uuid/uuid.dart';

class Room extends Equatable {
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
    User user = User(data['owner']['username'], data['owner']['uuid']);
    User? guest;
    if (data['guest'] != null) {
      String guestUsername = data['guest']['username'];
      String guestUuid = data['guest']['uuid'];
      guest = User(guestUsername, guestUuid);
    }
    return Room(
      owner: user,
      guest: guest,
      roomName: data['room_name'],
      roomId: data['room_id'],
    );
  }

  // Method to create a copy of Room with updated fields
  Room copyWith({
    User? owner,
    String? roomName,
    String? roomId,
    User? guest,
  }) {
    return Room(
      owner: owner ?? this.owner,
      roomName: roomName ?? this.roomName,
      roomId: roomId ?? this.roomId,
      guest: guest ?? this.guest,
    );
  }

  @override
  List<Object?> get props => [owner, roomName, roomId, guest];
}
