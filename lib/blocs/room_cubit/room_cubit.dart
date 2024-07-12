import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:meta/meta.dart';
import 'package:chess/chess.dart' as chesslib;
import 'package:simple_chess_board/simple_chess_board.dart';

import '../../models/room_model.dart';
import '../../models/user_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  bool hasJoined = false;
  final DatabaseService _databaseService = DatabaseService();
  final _firebaseDB = FirebaseDatabase.instance.ref();

  RoomCubit() : super(RoomInitial());

  StreamSubscription<DatabaseEvent>? _roomSubscription;
  bool _isListenerSet = false;

  void cancelRoomGuestUpdates() {
    print('Was listener null before cancelling: ${_roomSubscription == null}');
    _roomSubscription?.cancel();
    _isListenerSet = false;
  }

  void listenToRoomGuestUpdates(String roomId) async {
    //emit(RoomLoading());
    if (_isListenerSet) return;
    _isListenerSet = true;

    try {
      print("Setting up listener for room $roomId");
      _roomSubscription?.cancel();
      _roomSubscription = _firebaseDB
          .child('rooms/$roomId/guest')
          .onValue
          .listen((event) async {
        if (event.snapshot.value != null) {
          //emit(RoomLoading());
          final roomSnapshot = await _firebaseDB.child('rooms/$roomId').once();
          if (roomSnapshot.snapshot.value != null) {
            print(
                'Did host received a new guest?: ${roomSnapshot.snapshot.value.toString()}');
            final roomData = Map<String, dynamic>.from(
                roomSnapshot.snapshot.value as dynamic);
            final updatedRoom = Room.fromRTDB(roomData);
            //print(updatedRoom.guest?.username);

            emit(RoomLoaded(updatedRoom));
          }
        }
      });
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.toString()}');
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> createRoom(Room room) async {
    try {
      emit(RoomLoading());
      await _databaseService.addRoomToDB(room);
      emit(RoomLoaded(room));
      //listenToRoomGuestUpdates(room.roomId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> leaveRoom(Room room, User user) async {
    try {
      if (room.owner.uuid == user.uuid) {
        // Host wants to leave the room
        // so guest also must be removed
        // and room must be disposed
        print('Host wants to dispose the room');
      } else {
        // Guest wants to leave the room
        print('Guest want to leave the room');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateRoomGuest(Room room, User user) async {
    try {
      //emit(RoomLoading());
      final updatedRoom = room.copyWith(guest: user);
      await _databaseService.updateRoomInDB(updatedRoom);
      //emit(RoomLoaded(updatedRoom));
    } on FirebaseException catch (e) {
      print('Firebase Exception: $e');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> initializeGameInTheRoom(Room room) async {
    print('Host is initializing the game');
  }

  @override
  Future<void> close() {
    _roomSubscription?.cancel();
    return super.close();
  }
}
