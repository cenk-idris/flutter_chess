import 'package:uuid/uuid.dart';

import 'invite_model.dart';

class User {
  final String username;
  String uuid;
  String? color;
  List<Invite> invites = [];

  User(this.username, this.uuid);
}
