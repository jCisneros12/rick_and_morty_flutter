import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/items_local_datasource.dart';
import '../datasources/items_remote_datasource.dart';
class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsRemoteDataSource remoteDataSource;
  final ItemsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ItemsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CharacterEntity>>> getCharacters(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDataSource.getCharacters(page);
        await localDataSource.cacheCharacters(models);
        return Right(models.map((m) => m.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      if (page > 1) return const Left(NetworkFailure('No internet connection'));
      try {
        final cached = await localDataSource.getCachedCharacters();
        return Right(cached.map((m) => m.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, CharacterEntity>> getCharacterDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getCharacterDetail(id);
        await localDataSource.cacheCharacterDetail(model);
        return Right(model.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      final cached = await localDataSource.getCachedCharacterDetail(id);
      if (cached != null) {
        return Right(cached.toEntity());
      }
      return const Left(CacheFailure('No cached detail available'));
    }
  }
}
