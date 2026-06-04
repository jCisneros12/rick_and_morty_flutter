import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/character_entity.dart';

abstract class ItemsRepository {
  Future<Either<Failure, List<CharacterEntity>>> getCharacters(int page);
  Future<Either<Failure, CharacterEntity>> getCharacterDetail(int id);
}
