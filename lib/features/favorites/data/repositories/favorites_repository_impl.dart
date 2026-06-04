import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';
import '../models/favorite_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites() async {
    try {
      final models = await localDataSource.getFavorites();
      return Right(models.map((m) => FavoriteEntity(
        id: m.id,
        name: m.name,
        image: m.image,
        status: m.status,
        species: m.species,
      )).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int id) async {
    try {
      return Right(await localDataSource.isFavorite(id));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(FavoriteEntity favorite) async {
    try {
      final model = FavoriteModel(
        id: favorite.id,
        name: favorite.name,
        image: favorite.image,
        status: favorite.status,
        species: favorite.species,
      );
      await localDataSource.toggleFavorite(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
