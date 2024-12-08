import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dun_cookie_flutter/common/data_status.dart';
import 'package:dun_cookie_flutter/common/dun_dialog.dart';
import 'package:dun_cookie_flutter/common/package_info.dart';
import 'package:dun_cookie_flutter/manager/dunPreference.dart';
import 'package:dun_cookie_flutter/manager/settingManager.dart';
import 'package:dun_cookie_flutter/model/ceobe/version/dun_app.dart';
import 'package:dun_cookie_flutter/request/ceobe/ceobe_request.dart';
import 'package:dun_cookie_flutter/request/request.dart';
import 'package:dun_cookie_flutter/route.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import 'state.dart';

class UpdateLogic extends GetxController {
  static UpdateLogic? get to =>
      Get.isRegistered<UpdateLogic>() ? Get.find<UpdateLogic>() : null;
  final UpdateState state = UpdateState();

  @override
  void onInit() {
    super.onInit();
    state.nowVersion = SettingManager.getInstance().version;
    _deleteLocalApkFile(state.nowVersion);
  }

  Future<bool> checkLatestVersion({bool autoCheck = false}) async {
    final resp = await CeobeApi.getAppVersionInfo(version: state.nowVersion);
    final latestApp = resp.data;
    if (resp.error || latestApp == null) return false;

    final lastShowedVersion = getLastShowVersion(),
        latestVersion = latestApp.version,
        nowVersion = state.nowVersion;
    // 非首次启动，且当前版本为最新版本，并且没有弹出过当前版本的更新内容
    final isNotFirstLaunch = (getLaunchCount() ?? 0) > 0;
    if (isNotFirstLaunch &&
        nowVersion == latestVersion &&
        nowVersion != lastShowedVersion) {
      showUpdateInfoDialog(latestApp);
      return false;
    }

    bool isNew = PackageInfoPlus.isVersionHigher(latestVersion, nowVersion);
    if (!isNew) {
      if (autoCheck) _tryShowTapStarDialog();
      return false;
    }

    for (final source in latestApp.downloadSources) {
      source.primaryUrl.name = source.name;
    }
    state.dunAppInfo = latestApp;
    state.isForce = PackageInfoPlus.isVersionHigher(
        latestApp.previousMandatoryVersion, nowVersion);
    if (autoCheck) {
      showUpdateDialog(
          nowAppVersion: nowVersion, newApp: latestApp, isForce: state.isForce);
    } else {
      DunToast.showInfo("当前版本已过时，为您跳转到更新页面");
      Get.toNamed(DunRouter.update);
    }
    _parseAllUrlModel(latestApp);
    return true;
  }

  void _parseAllUrlModel(DunAppInfoModel latestApp) {
    bool urlModelIsSupportAndroid(DownloadUrlModel urlModel) {
      return urlModel.supportPlatforms.contains('Android');
    }

    bool urlModelIsDownloadable(DownloadUrlModel urlModel) {
      return urlModelIsSupportAndroid(urlModel) && !urlModel.manual;
    }

    bool urlModelIsManual(DownloadUrlModel urlModel) {
      return urlModelIsSupportAndroid(urlModel) && urlModel.manual;
    }

    state.downloadableUrlModels.clear();
    state.manualUrlModels.clear();
    for (final sourceModel in latestApp.downloadSources) {
      final allUrlModels = [sourceModel.primaryUrl, ...sourceModel.spareUrls];
      state.downloadableUrlModels
          .addAll(allUrlModels.where(urlModelIsDownloadable));
      state.manualUrlModels.addAll(allUrlModels.where(urlModelIsManual));
    }
  }

  void _tryShowTapStarDialog() {
    if (Platform.isIOS && getLaunchCount() == 10) {
      showTapStarDialog();
    }
  }

  void onTapDownload() async {
    state.downloadStatus = DataStatus.loading;
    update([state.downloadGID]);
    final isSuccess = await _downloadApp();
    state.downloadStatus = isSuccess ? DataStatus.success : DataStatus.error;
    update([state.downloadGID]);
  }

  Future<bool> _downloadApp() async {
    if (state.downloadableUrlModels.isEmpty) {
      DunToast.showInfo('未发现下载链接');
      return false;
    }

    state.downloadSavePath = await _genAppSavePath(state.newVersion);
    if (state.downloadSavePath == null) {
      DunToast.showInfo('获取下载路径失败');
      return false;
    }
    print('下载路径：${state.downloadSavePath}');

    for (final urlModel in state.downloadableUrlModels) {
      print('下载 ${urlModel.url}');
      state.downloadProgressController.total = 0;
      state.downloadProgressController.count = 0;

      state.curDownloadUrlModel = urlModel;
      update([state.downloadGID]);

      final resp = await HttpClass.download(
        savePath: state.downloadSavePath!,
        urlPath: urlModel.url,
        onReceiveProgress: (count, total) {
          state.downloadProgressController.total = total;
          state.downloadProgressController.count = count;
        },
      );
      if (resp.rawData == true) {
        installApp();
        return true;
      }
      print('下载错误，尝试下一个');
    }
    DunToast.showInfo('下载失败，请手动下载');
    return false;
  }

  /// 生成安装包本地保存路径
  Future<String?> _genAppSavePath(String version) async {
    final dir = await getExternalStorageDirectory();
    if (dir == null) return null;
    final savePath = p.join(dir.path, 'Ceobe-Canteen-$version.apk');
    return savePath;
  }

  Future<bool> installApp() async {
    final savePath = state.downloadSavePath;
    if (savePath == null || !File(savePath).existsSync()) {
      DunToast.showInfo('未找到安装包');
      return false;
    }
    try {
      await AppInstaller.installApk(savePath);
      return true;
    } catch (e) {
      DunToast.showInfo('安装错误');
      return false;
    }
  }

  void jumpWebPage(String url) {
    DunJump.openWebPage(url);
  }

  void jumpAppStore() {
    DunJump.openAppUrlScheme(
      "https://apps.apple.com/cn/app/id1629917304",
    );
  }

  void onTapBack() {
    if (state.isForce) {
      DunToast.showInfo("这波啊，是强制更新");
    } else {
      Get.back();
    }
  }

  Future<bool> onWillBack() async {
    if (state.isForce) {
      DunToast.showInfo("这波啊，是强制更新");
      return false;
    } else {
      return true;
    }
  }

  /// 删除下载的当前版本的安装包
  Future<bool> _deleteLocalApkFile(String version) async {
    final path = await _genAppSavePath(version);
    if (path == null) return true;

    final file = File(path);
    if (!await file.exists()) return true;

    try {
      await File(path).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
