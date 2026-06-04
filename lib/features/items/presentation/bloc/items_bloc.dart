import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/usecases/get_characters_usecase.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetCharactersUseCase getCharactersUseCase;

  int _currentPage = 1;

  ItemsBloc({required this.getCharactersUseCase}) : super(ItemsInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMore);
    on<RefreshCharacters>(_onRefresh);
  }

  Future<void> _onLoadCharacters(LoadCharacters event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    _currentPage = 1;

    final result = await getCharactersUseCase(GetCharactersParams(page: _currentPage));
    result.fold(
      (failure) => emit(ItemsError(failure.message)),
      (characters) {
        if (characters.isEmpty) {
          emit(ItemsEmpty());
        } else {
          emit(ItemsLoaded(characters: characters));
        }
      },
    );
  }

  Future<void> _onLoadMore(LoadMoreCharacters event, Emitter<ItemsState> emit) async {
    if (state is! ItemsLoaded) return;
    final current = state as ItemsLoaded;
    if (current.hasReachedMax) return;

    _currentPage++;
    final result = await getCharactersUseCase(GetCharactersParams(page: _currentPage));
    result.fold(
      (failure) {
        _currentPage--;
        emit(current.copyWith(hasReachedMax: true));
      },
      (newCharacters) {
        if (newCharacters.isEmpty) {
          emit(current.copyWith(hasReachedMax: true));
        } else {
          emit(current.copyWith(
            characters: [...current.characters, ...newCharacters],
          ));
        }
      },
    );
  }

  Future<void> _onRefresh(RefreshCharacters event, Emitter<ItemsState> emit) async {
    add(LoadCharacters());
  }
}
