import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/device_info_entity.dart';
import '../../domain/usecases/get_device_info_usecase.dart';

part 'device_info_event.dart';
part 'device_info_state.dart';

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final GetDeviceInfoUseCase getDeviceInfoUseCase;

  DeviceInfoBloc({required this.getDeviceInfoUseCase}) : super(DeviceInfoInitial()) {
    on<LoadDeviceInfo>(_onLoad);
  }

  Future<void> _onLoad(LoadDeviceInfo event, Emitter<DeviceInfoState> emit) async {
    emit(DeviceInfoLoading());
    final result = await getDeviceInfoUseCase(NoParams());
    result.fold(
      (failure) => emit(DeviceInfoError(failure.message)),
      (info) => emit(DeviceInfoLoaded(info: info)),
    );
  }
}
