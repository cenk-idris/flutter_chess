import 'package:uuid/uuid.dart';

import 'invite_model.dart';

class User {
  final String username;
  final String uuid = Uuid().v4();
  String? color;
  List<Invite> invites = [];

  User(this.username);
}
