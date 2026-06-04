import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/character_model.dart';

abstract class ItemsLocalDataSource {
  Future<List<CharacterModel>> getCachedCharacters();
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<CharacterModel?> getCachedCharacterDetail(int id);
  Future<void> cacheCharacterDetail(CharacterModel character);
}

class ItemsLocalDataSourceImpl implements ItemsLocalDataSource {
  final Box<CharacterModel> box;

  ItemsLocalDataSourceImpl(this.box);

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    final characters = box.values.toList();
    if (characters.isEmpty) throw const CacheException('No cached data');
    return characters;
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final map = {for (var c in characters) c.id.toString(): c};
    await box.putAll(map);
  }

  @override
  Future<CharacterModel?> getCachedCharacterDetail(int id) async {
    return box.get(id.toString());
  }

  @override
  Future<void> cacheCharacterDetail(CharacterModel character) async {
    await box.put(character.id.toString(), character);
  }
}
