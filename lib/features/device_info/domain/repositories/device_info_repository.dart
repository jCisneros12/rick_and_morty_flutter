import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/device_info_entity.dart';

abstract class DeviceInfoRepository {
  Future<Either<Failure, DeviceInfoEntity>> getDeviceInfo();
}
