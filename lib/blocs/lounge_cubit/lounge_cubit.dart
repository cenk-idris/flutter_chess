import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/room_model.dart';

class LoungeCubit extends Cubit<List<Room>> {
  List<Room> _lounge = [];
  final _firebaseDb = FirebaseDatabase.instance.ref();

  List<Room> get lounge => _lounge;

  static const kRoomsPath = 'rooms';

  late StreamSubscription _loungeStream;

  LoungeCubit() : super([]) {
    _listenToLoungeUpdates();
  }

  void _listenToLoungeUpdates() {
    _loungeStream = _firebaseDb.child(kRoomsPath).onValue.listen((event) {
      if (event.snapshot.value != null) {
        final allRooms =
            Map<String, dynamic>.from(event.snapshot.value as dynamic);
        _lounge = allRooms.values
            .map((lobbyAsJSON) => Room.fromRTDB(Map<String, dynamic>.from(
                Map<String, dynamic>.from(lobbyAsJSON))))
            .toList();
      } else {
        _lounge = [];
      }
      emit(_lounge);
    });
  }
}
