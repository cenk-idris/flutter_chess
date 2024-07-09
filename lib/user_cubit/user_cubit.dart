import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';

import '../models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserNotRegistered());

  Future<void> addUser(String username) async {
    print('hello');
    emit(UserBeingRegistered());
    try {
      final User newUser = User(username);
      await DatabaseService().addUserToDB(newUser);
      emit(UserRegistered(newUser));
    } on FirebaseException catch (e) {
      print('FireException: $e');
      emit(UserRegistrationError(e.toString()));
    } catch (e) {
      emit(UserRegistrationError(e.toString()));
    }
    print(state);
  }
}
