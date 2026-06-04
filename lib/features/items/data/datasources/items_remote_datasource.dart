import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/character_model.dart';

abstract class ItemsRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
  Future<CharacterModel> getCharacterDetail(int id);
}

class ItemsRemoteDataSourceImpl implements ItemsRemoteDataSource {
  final Dio dio;

  ItemsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/character',
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }

  @override
  Future<CharacterModel> getCharacterDetail(int id) async {
    try {
      final response = await dio.get('${AppConstants.baseUrl}/character/$id');
      return CharacterModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }
}
