import 'package:bloc/bloc.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';
import 'package:meta/meta.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final DatabaseService _databaseService = DatabaseService();

  RoomCubit() : super(RoomInitial());
}
