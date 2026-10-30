import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoPlus {
  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  static Future<bool> isVersionHigherThenNow(String? newVersion) async {
    if (newVersion == null) {
      return true;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String nowVersion = packageInfo.version;
    return isVersionHigher(newVersion, nowVersion);
  }

  static bool isVersionHigher(String? newVersion, String? nowVersion) {
    if (newVersion == null ||
        nowVersion == null ||
        newVersion == '' ||
        nowVersion == '') {
      return false;
    }
    final newParts = newVersion.split('.').map(int.tryParse).toList();
    final oldParts = nowVersion.split('.').map(int.tryParse).toList();
    if (newParts.any((part) => part == null || part < 0) ||
        oldParts.any((part) => part == null || part < 0)) {
      return false;
    }
    final newVersionList = newParts.cast<int>();
    final versionList = oldParts.cast<int>();
    // 判断lastForceVersion
    for (var i = 0;
        i <
            (versionList.length > newVersionList.length
                ? versionList.length
                : newVersionList.length);
        i++) {
      final next = i < newVersionList.length ? newVersionList[i] : 0;
      final previous = i < versionList.length ? versionList[i] : 0;
      if (next > previous) {
        return true;
      } else if (next < previous) {
        return false;
      }
    }
    return false;
  }
}
