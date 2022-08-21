
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoPlus {
  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  static Future<bool> isVersionHigher(String newVersion) async {
    // newVersion = '100.0.0';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    final List<int> newVersionList =
        newVersion.split(".").map((a) => int.parse(a)).toList();
    final List<int> versionList =
        version.split(".").map((a) => int.parse(a)).toList();
    // 判断lastFocusVersion
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
