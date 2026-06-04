part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<CharacterEntity> characters;
  final bool hasReachedMax;
  final bool isOffline;

  ItemsLoaded({
    required this.characters,
    this.hasReachedMax = false,
    this.isOffline = false,
  });

  ItemsLoaded copyWith({
    List<CharacterEntity>? characters,
    bool? hasReachedMax,
    bool? isOffline,
  }) {
    return ItemsLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [characters, hasReachedMax, isOffline];
}

class ItemsError extends ItemsState {
  final String message;
  ItemsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ItemsEmpty extends ItemsState {}
