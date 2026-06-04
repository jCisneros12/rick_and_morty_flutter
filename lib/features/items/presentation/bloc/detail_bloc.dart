import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/usecases/get_character_detail_usecase.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetCharacterDetailUseCase getCharacterDetailUseCase;

  DetailBloc({required this.getCharacterDetailUseCase}) : super(DetailInitial()) {
    on<LoadCharacterDetail>(_onLoadDetail);
  }

  Future<void> _onLoadDetail(LoadCharacterDetail event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    final result = await getCharacterDetailUseCase(GetCharacterDetailParams(id: event.id));
    result.fold(
      (failure) => emit(DetailError(failure.message)),
      (character) => emit(DetailLoaded(character: character)),
    );
  }
}
