import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/network/network_info.dart';
import 'features/device_info/data/datasources/device_platform_datasource.dart';
import 'features/device_info/data/repositories/device_info_repository_impl.dart';
import 'features/device_info/domain/repositories/device_info_repository.dart';
import 'features/device_info/domain/usecases/get_device_info_usecase.dart';
import 'features/device_info/presentation/bloc/device_info_bloc.dart';
import 'features/favorites/data/datasources/favorites_local_datasource.dart';
import 'features/favorites/data/models/favorite_model.dart';
import 'features/favorites/data/repositories/favorites_repository_impl.dart';
import 'features/favorites/domain/repositories/favorites_repository.dart';
import 'features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'features/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/items/data/datasources/items_local_datasource.dart';
import 'features/items/data/datasources/items_remote_datasource.dart';
import 'features/items/data/models/character_model.dart';
import 'features/items/data/repositories/items_repository_impl.dart';
import 'features/items/domain/repositories/items_repository.dart';
import 'features/items/domain/usecases/get_character_detail_usecase.dart';
import 'features/items/domain/usecases/get_characters_usecase.dart';
import 'features/items/presentation/bloc/detail_bloc.dart';
import 'features/items/presentation/bloc/items_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());
  final charactersBox = await Hive.openBox<CharacterModel>(AppConstants.charactersBox);
  final favoritesBox = await Hive.openBox<FavoriteModel>(AppConstants.favoritesBox);

  // BLoCs
  sl.registerFactory(() => ItemsBloc(getCharactersUseCase: sl()));
  sl.registerFactory(() => DetailBloc(getCharacterDetailUseCase: sl()));
  sl.registerFactory(() => FavoritesBloc(
        getFavoritesUseCase: sl(),
        toggleFavoriteUseCase: sl(),
      ));
  sl.registerFactory(() => DeviceInfoBloc(getDeviceInfoUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCharactersUseCase(sl()));
  sl.registerLazySingleton(() => GetCharacterDetailUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetDeviceInfoUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ItemsRepository>(() => ItemsRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(sl()));
  sl.registerLazySingleton<DeviceInfoRepository>(() => DeviceInfoRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<ItemsRemoteDataSource>(() => ItemsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ItemsLocalDataSource>(() => ItemsLocalDataSourceImpl(charactersBox));
  sl.registerLazySingleton<FavoritesLocalDataSource>(() => FavoritesLocalDataSourceImpl(favoritesBox));
  sl.registerLazySingleton<DevicePlatformDataSource>(() => DevicePlatformDataSourceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Dio());
}
