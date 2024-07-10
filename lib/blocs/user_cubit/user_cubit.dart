import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chess/services/firebase_RTDB_service.dart';

import '../../models/invite_model.dart';
import '../../models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  User? _user;
  User? get user => _user;

  List<Invite> _invites = [];
  List<Invite> get invites => _invites;

  late StreamSubscription _invitesSubscription;

  final _firebaseDb = FirebaseDatabase.instance.ref();

  UserCubit() : super(UserNotRegistered());

  Future<void> addUser(String username) async {
    emit(UserBeingRegistered());
    try {
      final User newUser = User(username);
      await DatabaseService().addUserToDB(newUser);
      _user = newUser;
      _listenToInvitesForCurrentUser();
      emit(UserRegistered(newUser));
    } on FirebaseException catch (e) {
      print('FireException: $e');
      emit(UserRegistrationError(e.toString()));
    } catch (e) {
      emit(UserRegistrationError(e.toString()));
    }
    print(user?.username);
  }

  void _listenToInvitesForCurrentUser() async {
    _invitesSubscription = _firebaseDb
        .child('users/${user?.uuid}/invites')
        .onValue
        .listen((event) {
      print('something changed in invites');
    });
  }
}
