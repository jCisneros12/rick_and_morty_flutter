import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/device_info_entity.dart';
import '../../domain/repositories/device_info_repository.dart';
import '../datasources/device_platform_datasource.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DevicePlatformDataSource dataSource;

  DeviceInfoRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, DeviceInfoEntity>> getDeviceInfo() async {
    try {
      final data = await dataSource.getDeviceInfo();
      return Right(DeviceInfoEntity(
        manufacturer: data['manufacturer'] ?? 'Unknown',
        model: data['model'] ?? 'Unknown',
        androidVersion: data['androidVersion'] ?? 'Unknown',
        batteryLevel: data['batteryLevel'] ?? -1,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
