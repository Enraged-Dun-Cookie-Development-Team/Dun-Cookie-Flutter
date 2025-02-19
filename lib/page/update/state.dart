import 'package:dio/dio.dart';

import '../../common/data_status.dart';
import '../../model/ceobe/version/dun_app.dart';
import '../../widget/progress.dart';

class UpdateState {
  String nowVersion = '0.0.0';
  bool checking = false;

  DunAppInfoModel dunAppInfo = DunAppInfoModel.fromJson({});
  bool isForce = false;
  String get newVersion => dunAppInfo.version;
  String get description => dunAppInfo.description;

  final List<DownloadUrlModel> downloadableUrlModels = [];
  final List<DownloadUrlModel> manualUrlModels = [];
  DownloadUrlModel? curDownloadUrlModel;

  CancelToken? appCancelToken;
  final ProgressController downloadProgressController = ProgressController();
  DataStatus? downloadStatus;
  String? downloadSavePath;

  String rootGID = "rootGID";
  String downloadGID = "downloadGID";
  String checkGID = "checkGID";

  UpdateState() {
    ///Initialize variables
  }
}
