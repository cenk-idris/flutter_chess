import 'package:uuid/uuid.dart';

import 'invite_model.dart';

class User {
  final String username;
  String uuid;
  String? color;
  List<Invite> invites = [];

  User(this.username, this.uuid, [this.color]);

  factory User.fromRTDB(Map<String, dynamic> data) {
    return User(
      data['username'],
      data['uuid'],
      data['color'],
    );
  }

  Map<String, dynamic> toJson({bool includeColor = true}) {
    final data = {
      'username': username,
      'uuid': uuid,
    };
    if (includeColor && color != null) {
      data['color'] = color!;
    }
    return data;
  }
}
