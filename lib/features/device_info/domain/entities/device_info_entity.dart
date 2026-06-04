import 'package:equatable/equatable.dart';

class DeviceInfoEntity extends Equatable {
  final String manufacturer;
  final String model;
  final String androidVersion;
  final int batteryLevel;

  const DeviceInfoEntity({
    required this.manufacturer,
    required this.model,
    required this.androidVersion,
    required this.batteryLevel,
  });

  @override
  List<Object?> get props => [manufacturer, model, androidVersion, batteryLevel];
}
