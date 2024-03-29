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
    if (newVersion == null || nowVersion == null) {
      return false;
    }
    final List<int> newVersionList = newVersion.split(".").map((a) => int.parse(a)).toList();
    final List<int> versionList = nowVersion.split(".").map((a) => int.parse(a)).toList();
    // 判断lastForceVersion
    for (var i = 0;
        i <
            (versionList.length < newVersionList.length
                ? versionList.length
                : newVersionList.length);
        i++) {
      if (newVersionList[i] > versionList[i]) {
        return true;
      } else if (newVersionList[i] < versionList[i]) {
        return false;
      }
    }
    return false;
  }
}
