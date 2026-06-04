part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final CharacterEntity character;
  DetailLoaded({required this.character});

  @override
  List<Object?> get props => [character];
}

class DetailError extends DetailState {
  final String message;
  DetailError(this.message);

  @override
  List<Object?> get props => [message];
}
