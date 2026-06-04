import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/device_info_entity.dart';
import '../repositories/device_info_repository.dart';

class GetDeviceInfoUseCase implements UseCase<DeviceInfoEntity, NoParams> {
  final DeviceInfoRepository repository;

  GetDeviceInfoUseCase(this.repository);

  @override
  Future<Either<Failure, DeviceInfoEntity>> call(NoParams params) {
    return repository.getDeviceInfo();
  }
}
