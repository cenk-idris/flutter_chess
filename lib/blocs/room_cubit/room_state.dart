part of 'room_cubit.dart';

@immutable
sealed class RoomState extends Equatable {
  @override
  List<Object> get props => [];
}

final class RoomInitial extends RoomState {}

final class RoomLoaded extends RoomState {
  final Room room;
  RoomLoaded(this.room);

  @override
  List<Object> get props => [room];
}

final class RoomLoading extends RoomState {}

final class RoomError extends RoomState {
  final String message;

  RoomError(this.message);
  @override
  List<Object> get props => [message];
}

final class GameStarted extends RoomState {
  final Room room;
  GameStarted(this.room);

  @override
  List<Object> get props => [room];
}
