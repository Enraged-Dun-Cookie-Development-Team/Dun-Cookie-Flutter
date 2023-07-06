import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/config_datasource_model.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/set_up/set_up_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/user_settings.dart';
import '../request/base_config_request.dart';
import '../request/info_request.dart';

class SetUpDatasource extends StatefulWidget {
  const SetUpDatasource({Key? key}) : super(key: key);

  static String routerName = "/set_up_datasource";

  @override
  _SetUpDatasourceState createState() => _SetUpDatasourceState();
}

class _SetUpDatasourceState extends State<SetUpDatasource> {
  late SettingProvider settingData;
  // 获取所有数据源列表列表
  List<ConfigDatasourceModel> allDatasouces = [];
  // 获取用户数据源
  List<String> userDatasourceUuids = [];

  _getAllDatasource() async {
    var datasources = await BaseConfigRequest.getConfigDatasource();
    setState(() {
      allDatasouces = datasources;
    });
  }

  _getUserDatasource(SettingProvider settingData) async {
    UserDatasourceSettings userSettings =
        await InfoRequest.getUserDatasourceSettings();
    settingData.saveDatasourceSetting(userSettings);
    setState(() {
      userDatasourceUuids =
          settingData.appSetting.datasourceSetting!.datasourceConfig!;
    });
  }

  @override
  void initState() {
    _getAllDatasource();
    settingData = Provider.of<SettingProvider>(context, listen: false);
    if (settingData.appSetting.datasourceSetting?.datasourceConfig == null) {
      _getUserDatasource(settingData);
    }
    userDatasourceUuids
        .addAll(settingData.appSetting.datasourceSetting!.datasourceConfig!);
    // 获取已保存的数据
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        eventBus.fire(ChangeSourceBus());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("饼来源"),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => SetUpItem(
                  userSelectedList: userDatasourceUuids,
                  data: allDatasouces[index],
                ),
                itemCount: allDatasouces.length,
              ),
            ),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () async {
        bool saveSucceed =
            await BaseConfigRequest.updateDataSource(userDatasourceUuids);
        if (saveSucceed) {
          DunToast.showInfo("保存成功");
          settingData.appSetting.datasourceSetting!.datasourceConfig!.clear();
          settingData.appSetting.datasourceSetting!.datasourceConfig!
              .addAll(userDatasourceUuids);
        } else {
          DunToast.showInfo("保存失败");
        }
      },
      child: Container(
        color: white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
              child: Text(
            "保存",
            style: TextStyle(
              color: white,
              fontSize: 16,
            ),
          )),
        ),
      ),
    );
  }
}
