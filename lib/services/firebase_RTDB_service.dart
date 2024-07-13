import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/room_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  static const kUsersPath = 'users';
  static const kRoomsPath = 'rooms';
  static const kGamesPath = 'games';

  Future<void> addUserToDB(User user) async {
    final usersRef = database.child(kUsersPath);
    try {
      await usersRef
          .child(user.uuid)
          .set({'username': user.username, 'uuid': user.uuid});
    } catch (e) {
      throw Exception(e);
    }
  }

  //Future<void> addGameToTheRoomInDB

  Future<void> addRoomToDB(Room room) async {
    final roomsRef = database.child(kRoomsPath);
    try {
      await roomsRef.child(room.roomId).set({
        'room_id': room.roomId,
        'room_name': room.roomName,
        'owner': {'username': room.owner.username, 'uuid': room.owner.uuid},
        'guest': {
          'username': null,
          'uuid': null,
        },
      });
    } on FirebaseException catch (e) {
      print('Firebase Exception: $e');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateRoomInDB(Room room) async {
    final roomsRef = database.child(kRoomsPath);
    //print(room.toJson());
    try {
      await roomsRef.child(room.roomId).update(room.toJson());
    } on FirebaseException catch (e) {
      print('Firebase Exception: $e');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
