part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final FavoriteEntity favorite;
  ToggleFavorite(this.favorite);

  @override
  List<Object?> get props => [favorite];
}
