import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/room_model.dart';

class LoungeCubit extends Cubit<List<Room>> {
  final List<Room> _lounge = [];
  final _firebaseDb = FirebaseDatabase.instance.ref();

  List<Room> get lounge => _lounge;

  static const kLoungePath = 'lounge';

  late StreamSubscription _loungeSubscription;

  LoungeCubit() : super([]) {
    // call listener
  }

  void _listenToLoungeUpdates() {
    // _loungeStream = _firebaseDb.child(kLoungePath).onValue.listen((event) {
    //   if (event.snapshot.value != null) {
    //     final allRooms = Map<String, dynamic>.from(event.snapshot.value as dynamic);
    //   }
    // });
  }
}
