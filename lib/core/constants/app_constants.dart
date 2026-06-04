import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static const String deviceChannelName = 'com.explorerapp/device_info';
  static const String charactersBox = 'characters_box';
  static const String favoritesBox = 'favorites_box';
}
