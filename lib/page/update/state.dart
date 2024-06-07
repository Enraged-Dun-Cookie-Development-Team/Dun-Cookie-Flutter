import '../../model/ceobe/version/dun_app.dart';

class UpdateState {
  String nowVersion = '0.0.0';
  DunAppInfoModel dunAppInfo = DunAppInfoModel.fromJson({});

  bool get isFocus => dunAppInfo.force;

  String get version => dunAppInfo.version;

  String get description => dunAppInfo.description;

  String rootGID = "rootGID";

  UpdateState() {
    ///Initialize variables
  }
}
