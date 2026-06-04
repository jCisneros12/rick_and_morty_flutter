import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/favorite_entity.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavoriteUseCase implements UseCase<void, ToggleFavoriteParams> {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleFavoriteParams params) {
    return repository.toggleFavorite(params.favorite);
  }
}

class ToggleFavoriteParams extends Equatable {
  final FavoriteEntity favorite;
  const ToggleFavoriteParams({required this.favorite});

  @override
  List<Object?> get props => [favorite];
}
