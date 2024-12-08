import 'package:dio/dio.dart';
import 'package:dun_cookie_flutter/common/data_status.dart';
import 'package:dun_cookie_flutter/widget/progress.dart';

import '../../model/ceobe/version/dun_app.dart';

class UpdateState {
  String nowVersion = '0.0.0';
  DunAppInfoModel dunAppInfo = DunAppInfoModel.fromJson({});
  final List<DownloadUrlModel> downloadableUrlModels = [];
  final List<DownloadUrlModel> manualUrlModels = [];
  DownloadUrlModel? curDownloadUrlModel;
  CancelToken? appCancelToken;
  final ProgressController downloadProgressController = ProgressController();
  DataStatus? downloadStatus;
  String? downloadSavePath;

  bool isForce = false;

  String get newVersion => dunAppInfo.version;

  String get description => dunAppInfo.description;

  String rootGID = "rootGID";
  String downloadGID = "downloadGID";

  UpdateState() {
    ///Initialize variables
  }
}
