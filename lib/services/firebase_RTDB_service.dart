import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';

class DatabaseService {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  static const kUsersPath = 'users';
  static const kLobbiesPath = 'lobbies';
  static const kGamesPath = 'games';

  Future<void> addUserToDB(User user) async {
    final usersRef = database.child(kUsersPath);
    try {
      await usersRef
          .child(user.uuid)
          .set({'username': user.username, 'uuid': user.uuid});
    } catch (e) {}
  }
}
