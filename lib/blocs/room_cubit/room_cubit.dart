import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:meta/meta.dart';
import 'package:chess/chess.dart' as chesslib;
import 'package:simple_chess_board/simple_chess_board.dart';

import '../../models/game_model.dart';
import '../../models/room_model.dart';
import '../../models/user_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  bool hasJoined = false;
  final DatabaseService _databaseService = DatabaseService();
  final _firebaseDB = FirebaseDatabase.instance.ref();

  RoomCubit() : super(RoomInitial());

  StreamSubscription<DatabaseEvent>? _guestSubscription;
  bool _isGuestListenerSet = false;

  StreamSubscription<DatabaseEvent>? _gameSubscription;
  bool _isGameListenerSet = false;

  void cancelRoomGuestUpdates() {
    print('Was listener null before cancelling: ${_guestSubscription == null}');
    _guestSubscription?.cancel();
    _isGameListenerSet = false;
  }

  void cancelRoomGameUpdates() {
    print(
        'Game listener was null before cancelling: ${_gameSubscription == null}');
    _gameSubscription?.cancel();
    _isGameListenerSet = false;
  }

  void listenToRoomGameUpdates(String roomId) async {
    if (_isGameListenerSet) return;
    _isGameListenerSet = true;

    try {
      print('Setting up game listener for room ${roomId}');
      await _gameSubscription?.cancel();
      _gameSubscription =
          _firebaseDB.child('rooms/$roomId/game').onValue.listen((event) async {
        if (event.snapshot.value != null) {
          print('Yoo game is updated: ${event.snapshot.value.toString()}');
        }
      });
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  void listenToRoomGuestUpdates(String roomId) async {
    //emit(RoomLoading());
    if (_isGuestListenerSet) return;
    _isGuestListenerSet = true;

    try {
      print("Setting up guest listener for room $roomId");
      await _guestSubscription?.cancel();
      _guestSubscription = _firebaseDB
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
    final player1 = room.owner;
    final player2 = room.guest!;
    player1.color = 'white';
    player2.color = 'black';
    Game newGame = Game(
      players: {
        'player1': player1,
        'player2': player2,
      },
      status: 'started',
      currentMove: 'white',
      fen: chesslib.Chess.DEFAULT_POSITION,
    );
    final gameAddedRoom = room.copyWith(game: newGame);
    await _databaseService.updateRoomInDB(gameAddedRoom);
  }

  @override
  Future<void> close() {
    _guestSubscription?.cancel();
    return super.close();
  }
}
