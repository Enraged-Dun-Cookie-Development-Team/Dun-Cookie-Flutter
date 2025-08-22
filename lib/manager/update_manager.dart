import 'dart:async';
import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dio/dio.dart';
import 'package:dun_cookie_flutter/common/data_status.dart';
import 'package:dun_cookie_flutter/common/dun_dialog.dart';
import 'package:dun_cookie_flutter/common/dun_log.dart';
import 'package:dun_cookie_flutter/common/dun_toast.dart';
import 'package:dun_cookie_flutter/common/package_info.dart';
import 'package:dun_cookie_flutter/manager/dun_preference.dart';
import 'package:dun_cookie_flutter/manager/setting_manager.dart';
import 'package:dun_cookie_flutter/model/ceobe/version/dun_app.dart';
import 'package:dun_cookie_flutter/page/root/logic.dart';
import 'package:dun_cookie_flutter/request/ceobe/ceobe_request.dart';
import 'package:dun_cookie_flutter/request/request.dart';
import 'package:dun_cookie_flutter/route.dart';
import 'package:dun_cookie_flutter/widget/progress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class UpdateManager {
  static final _instance = UpdateManager._();

  UpdateManager._() {
    nowVersion = SettingManager.getInstance().version;
    _deleteLocalApkFile(nowVersion);
  }

  factory UpdateManager.getInstance() => _instance;

  /// 版本信息
  DunAppInfoModel dunAppInfo = DunAppInfoModel.fromJson({});
  String nowVersion = '0.0.0';
  bool isForce = false;
  final checking = false.obs;

  /// 下载渠道
  final List<DownloadUrlModel> downloadableUrlModels = [];
  final List<DownloadUrlModel> manualUrlModels = [];
  final curDownloadUrlModel = Rxn<DownloadUrlModel>();

  /// 下载进度
  final downloadProgressController = ProgressController();
  final downloadStatus = Rxn<DataStatus>();
  CancelToken? appCancelToken;
  String? downloadSavePath;

  void checkLatestVersion({bool autoCheck = false}) async {
    if (checking.isTrue) return;
    checking.value = true;

    await _checkLatestVersion(autoCheck: autoCheck);
    checking.value = false;
  }

  Future<bool> _checkLatestVersion({bool autoCheck = false}) async {
    final resp = await CeobeApi.getAppVersionInfo();
    final latestApp = resp.data;
    if (resp.error || latestApp == null) return false;

    final lastShowedVersion = getLastShowVersion();
    // 非首次启动，且当前版本为最新版本，并且没有弹出过当前版本的更新内容
    final isNotFirstLaunch = RootLogic.to?.isNotFirstLaunch ?? false;
    if (isNotFirstLaunch &&
        nowVersion == latestApp.version &&
        nowVersion != lastShowedVersion) {
      showUpdateInfoDialog(latestApp);
      return false;
    }

    bool isNew = PackageInfoPlus.isVersionHigher(latestApp.version, nowVersion);
    if (!isNew) {
      autoCheck ? _tryShowTapStarDialog() : DunToast.showInfo("当前已是最新版本");
      return false;
    }

    for (final source in latestApp.downloadSources) {
      source.primaryUrl.name = source.name;
    }
    dunAppInfo = latestApp;
    isForce = PackageInfoPlus.isVersionHigher(
        latestApp.previousMandatoryVersion, nowVersion);
    if (autoCheck) {
      showUpdateDialog(
          nowAppVersion: nowVersion, newApp: latestApp, isForce: isForce);
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

    downloadableUrlModels.clear();
    manualUrlModels.clear();
    for (final sourceModel in latestApp.downloadSources) {
      final allUrlModels = [sourceModel.primaryUrl, ...sourceModel.spareUrls];
      downloadableUrlModels.addAll(allUrlModels.where(urlModelIsDownloadable));
      manualUrlModels.addAll(allUrlModels.where(urlModelIsManual));
    }
  }

  void _tryShowTapStarDialog() {
    if (Platform.isIOS && getLaunchCount() == 10) {
      showTapStarDialog();
    }
  }

  void startDownload() async {
    downloadStatus.value = DataStatus.loading;
    downloadStatus.value = await _downloadApp();
  }

  void cancelDownload() {
    appCancelToken?.cancel();
    appCancelToken = null;
    downloadProgressController.total = 0;
    downloadProgressController.count = 0;
  }

  Future<DataStatus?> _downloadApp() async {
    if (downloadableUrlModels.isEmpty) {
      DunToast.showInfo('未发现下载链接');
      return DataStatus.error;
    }

    downloadSavePath = await _genAppSavePath(dunAppInfo.version);
    if (downloadSavePath == null) {
      DunToast.showInfo('获取下载路径失败');
      return DataStatus.error;
    }

    Timer? timer;
    for (final urlModel in downloadableUrlModels) {
      downloadProgressController.total = 0;
      downloadProgressController.count = 0;

      curDownloadUrlModel.value = urlModel;
      appCancelToken = CancelToken();
      timer = Timer(const Duration(seconds: 10), () {
        if (appCancelToken != null && downloadProgressController.count == 0) {
          cancelDownload();
        }
      });
      final resp = await HttpClass.download(
        savePath: downloadSavePath!,
        urlPath: urlModel.url,
        cancelToken: appCancelToken,
        onReceiveProgress: (count, total) {
          downloadProgressController.total = total;
          downloadProgressController.count = count;
        },
      );
      timer.cancel();
      if (resp.rawData == true) {
        installApp();
        return DataStatus.success;
      }
      if (appCancelToken == null) {
        return null;
      }
    }
    DunToast.showInfo('下载失败，请手动下载');
    return DataStatus.error;
  }

  Future<bool> installApp() async {
    final savePath = downloadSavePath;
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

  /// 生成安装包本地保存路径
  Future<String?> _genAppSavePath(String version) async {
    final dir = await getExternalStorageDirectory();
    if (dir == null) return null;
    final savePath = p.join(dir.path, 'Ceobe-Canteen-$version.apk');
    return savePath;
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
    } catch (err, stack) {
      DunLog.error("删除安装包失败", err, stack);
      return false;
    }
  }
}
