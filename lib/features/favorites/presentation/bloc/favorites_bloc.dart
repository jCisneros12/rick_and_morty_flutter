import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoad);
    on<ToggleFavorite>(_onToggle);
  }

  Future<void> _onLoad(LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    final result = await getFavoritesUseCase(NoParams());
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites: favorites)),
    );
  }

  Future<void> _onToggle(ToggleFavorite event, Emitter<FavoritesState> emit) async {
    await toggleFavoriteUseCase(ToggleFavoriteParams(favorite: event.favorite));
    add(LoadFavorites());
  }
}
