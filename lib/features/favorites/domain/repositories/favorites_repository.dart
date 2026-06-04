import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/favorite_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites();
  Future<Either<Failure, bool>> isFavorite(int id);
  Future<Either<Failure, void>> toggleFavorite(FavoriteEntity favorite);
}
