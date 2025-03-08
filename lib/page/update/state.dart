import '../../common/data_status.dart';
import '../../model/ceobe/version/dun_app.dart';
import '../../services/update_service.dart';
import '../../widget/progress.dart';

class UpdateState {
  bool get isForce => UpdateService.to?.isForce ?? false;
  String get nowVersion => UpdateService.to?.nowVersion ?? '';
  String get newVersion => UpdateService.to?.dunAppInfo.version ?? '';
  String get description => UpdateService.to?.dunAppInfo.description ?? '';

  ProgressController? get downloadProgressController =>
      UpdateService.to?.downloadProgressController;
  DownloadUrlModel? get curDownloadUrlModel =>
      UpdateService.to?.curDownloadUrlModel;
  DataStatus? get downloadStatus => UpdateService.to?.downloadStatus.value;
  List<DownloadUrlModel> get manualUrlModels =>
      UpdateService.to?.manualUrlModels ?? [];

  String rootGID = "rootGID";

  UpdateState() {
    ///Initialize variables
  }
}
