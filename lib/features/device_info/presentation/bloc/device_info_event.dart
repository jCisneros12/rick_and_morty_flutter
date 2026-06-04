part of 'device_info_bloc.dart';

abstract class DeviceInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDeviceInfo extends DeviceInfoEvent {}
