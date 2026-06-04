import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class DevicePlatformDataSource {
  Future<Map<String, dynamic>> getDeviceInfo();
}

class DevicePlatformDataSourceImpl implements DevicePlatformDataSource {
  static const _channel = MethodChannel(AppConstants.deviceChannelName);

  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod<Map>('getDeviceInfo');
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      throw ServerException(e.message ?? 'Platform channel error');
    }
  }
}
