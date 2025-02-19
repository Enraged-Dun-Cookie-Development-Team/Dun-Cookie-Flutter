import 'package:get/get.dart';

import '../../common/dun_dialog.dart';
import '../../common/dun_toast.dart';
import '../../manager/setting_manager.dart';
import '../../model/config/config_datasource.dart';
import '../../model/info/user_settings.dart';
import '../../request/config/config_request.dart';
import '../../request/info/info_request.dart';
import 'state.dart';

class DatasourceLogic extends GetxController {
  final DatasourceState state = DatasourceState();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    state.userDatasourceList.addAll(
        SettingManager.getInstance().datasourceSetting.value.datasourceList);
    const keys = Platform.values;
    final values =
        List<List<ConfigDatasourceModel>>.generate(keys.length, (index) => []);
    state.datasourceGroups = Map.fromIterables(keys, values);
    var responseData = await ConfigRequest.getConfigDatasource();
    if (responseData.error) {
      //请求配置数据源失败
    }
    var allDatasource = responseData.data;
    if (allDatasource != null) {
      for (var element in allDatasource) {
        if (state.datasourceGroups[element.platform] != null) {
          state.datasourceGroups[element.platform]?.add(element);
        } else {
          state.datasourceGroups[Platform.other]?.add(element);
        }
      }
      update([state.groupGID]);
    }
  }

  void onTapBack() {
    Get.back();
  }

  Future<void> onTapSave() async {
    showLoadingDialog();
    bool saveSucceed =
        (await InfoRequest.updateDataSource(state.userDatasourceList)).error;
    clearLoadingDialog();
    if (saveSucceed) {
      DunToast.showInfo("保存成功");
      var responseData = await InfoRequest.getUserDatasourceSettings();
      if (responseData.error) {
        return;
      }
      UserDatasourceModel? userDatasourceModel = responseData.data;
      if (userDatasourceModel != null) {
        SettingManager.getInstance().updateDataSource(userDatasourceModel);
        update([state.groupGID]);
      }
    } else {
      DunToast.showInfo("保存失败");
    }
  }

  bool onChangeDatasource(ConfigDatasourceModel datasource, bool value) {
    if (value) {
      state.userDatasourceList.add(datasource.uniqueId);
      return true;
    } else {
      if (state.userDatasourceList.length == 1) {
        DunToast.showError("至少关注一个哦");
        return true;
      } else {
        state.userDatasourceList.remove(datasource.uniqueId);
        return false;
      }
    }
  }
}
