part of 'device_info_bloc.dart';

abstract class DeviceInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceInfoInitial extends DeviceInfoState {}

class DeviceInfoLoading extends DeviceInfoState {}

class DeviceInfoLoaded extends DeviceInfoState {
  final DeviceInfoEntity info;
  DeviceInfoLoaded({required this.info});

  @override
  List<Object?> get props => [info];
}

class DeviceInfoError extends DeviceInfoState {
  final String message;
  DeviceInfoError(this.message);

  @override
  List<Object?> get props => [message];
}
