class Invite {
  final String lobbyName;
  final String lobbyId;
  final String lobbyOwnerName;

  Invite(
      {required this.lobbyName,
      required this.lobbyId,
      required this.lobbyOwnerName});

  factory Invite.fromRTDB(Map<String, dynamic> data) {
    try {
      if (data.containsKey('lobby_name') &&
          data.containsKey('lobby_id') &&
          data.containsKey('lobby_owner_name')) {
        return Invite(
          lobbyName: data['lobby_name'],
          lobbyId: data['lobby_id'],
          lobbyOwnerName: data['lobby_owner_name'],
        );
      } else {
        throw FormatException('Missing one or more required fields.');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
