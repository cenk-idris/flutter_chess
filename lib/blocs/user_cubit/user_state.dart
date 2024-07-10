part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserNotRegistered extends UserState {}

class UserBeingRegistered extends UserState {}

class UserRegistered extends UserState {
  final User user;

  UserRegistered(this.user);

  @override
  List<Object> get props => [user];
}

class UserRegistrationError extends UserState {
  final String message;

  const UserRegistrationError(this.message);
}
