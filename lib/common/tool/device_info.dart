import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static Future<String?> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      // https://pub.dev/packages/device_info_plus/changelog
      // 在 deviece_info_plus 4.0 版本中 Remove AndroidId getter to avoid Google Play policies violations
      // 但我寻思这函数也没人用啊 修了真的有必要咩
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      return androidId;
      // AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      // return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
