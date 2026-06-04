import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/favorite_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<FavoriteModel>> getFavorites();
  Future<bool> isFavorite(int id);
  Future<void> toggleFavorite(FavoriteModel model);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<FavoriteModel> box;

  FavoritesLocalDataSourceImpl(this.box);

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    return box.values.toList();
  }

  @override
  Future<bool> isFavorite(int id) async {
    return box.containsKey(id.toString());
  }

  @override
  Future<void> toggleFavorite(FavoriteModel model) async {
    try {
      final key = model.id.toString();
      if (box.containsKey(key)) {
        await box.delete(key);
      } else {
        await box.put(key, model);
      }
    } catch (e) {
      throw CacheException('Failed to toggle favorite');
    }
  }
}
