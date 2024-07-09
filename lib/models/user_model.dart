import 'package:uuid/uuid.dart';

class User {
  final String username;
  final String uuid = Uuid().v4();
  String? color;

  User(this.username);
}
