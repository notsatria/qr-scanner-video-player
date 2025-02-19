import 'dart:developer';

import 'package:flutter/services.dart';

class AppSettingsHelper {
  static const MethodChannel _channel = MethodChannel('app_settings_channel');

  static Future<bool> openAppSettings() async {
    try {
      final bool result = await _channel.invokeMethod('openAppSettings');
      return result;
    } on PlatformException catch (e) {
      log('Failed to open app settings: ${e.message}');
      return false;
    }
  }
}
