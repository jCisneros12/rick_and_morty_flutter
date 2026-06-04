import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character_entity.dart';
import '../repositories/items_repository.dart';

class GetCharacterDetailUseCase implements UseCase<CharacterEntity, GetCharacterDetailParams> {
  final ItemsRepository repository;

  GetCharacterDetailUseCase(this.repository);

  @override
  Future<Either<Failure, CharacterEntity>> call(GetCharacterDetailParams params) {
    return repository.getCharacterDetail(params.id);
  }
}

class GetCharacterDetailParams extends Equatable {
  final int id;
  const GetCharacterDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
