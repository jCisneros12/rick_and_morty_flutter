import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character_entity.dart';
import '../repositories/items_repository.dart';

class GetCharactersUseCase implements UseCase<List<CharacterEntity>, GetCharactersParams> {
  final ItemsRepository repository;

  GetCharactersUseCase(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(GetCharactersParams params) {
    return repository.getCharacters(params.page);
  }
}

class GetCharactersParams extends Equatable {
  final int page;
  const GetCharactersParams({required this.page});

  @override
  List<Object?> get props => [page];
}
