import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:meta/meta.dart';

import '../../models/room_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  bool hasJoined = false;
  final DatabaseService _databaseService = DatabaseService();

  RoomCubit() : super(RoomInitial());

  Future<void> createRoom(Room room) async {
    try {
      emit(RoomLoading());
      await _databaseService.addRoomToDB(room);
      emit(RoomLoaded(room));
    } catch (e) {
      throw Exception(e);
    }
  }
}
