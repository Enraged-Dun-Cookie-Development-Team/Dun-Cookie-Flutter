import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/config_datasource_model.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../model/user_settings.dart';
import '../../request/base_config_request.dart';
import '../../request/info_request.dart';
import 'data/platform.dart';
import 'ui/set_up_item.dart';

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
    settingData.saveAppSetting();
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
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: WillPopScope(
          onWillPop: () async {
            eventBus.fire(ChangeSourceBus());
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => {Navigator.of(context).pop('刷新')}),
              leadingWidth: 50,
              iconTheme: const IconThemeData(
                color: DunColors.DunColor,
              ),
              titleTextStyle:
                  const TextStyle(color: DunColors.DunColor, fontSize: 20),
              titleSpacing: 0,
              // 为啥别人都没去就你去了 要去一起去
              // elevation: 0,
              title: const Text("饼来源"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    color: gray_3,
                    child: SingleChildScrollView(
                      child: _buildBody(),
                    ),
                  ),
                ),
                _buildSaveButton(),
              ],
            ),
          ),
        ));
  }

  static List<Platform> platformList = [
    Platform("bilibili", "B站"),
    Platform("weibo", "微博"),
    Platform("netease-cloud-music", "网易云音乐"),
    Platform("arknights-game", "明日方舟游戏内"),
    Platform("arknights-website", "明日方舟网站"),
    Platform("", "其他"),
  ];

  Widget _buildBody() {
    Set<String?> isInit = {};
    List<Widget> body = [];
    for (var platform in platformList) {
      List<Widget> list = [];
      for (var model in allDatasouces) {
        if (isInit.contains(model.uniqueId)) continue;
        if (model.platform == platform.id || platform.name == "其他") {
          if (list.isNotEmpty) {
            list.add(const Divider(
              height: 1,
              indent: 7,
              endIndent: 7,
            ));
          }
          list.add(SetUpItem(
            userSelectedList: userDatasourceUuids,
            data: model,
          ));
          isInit.add(model.uniqueId);
        }
      }
      if (list.isNotEmpty) {
        body.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 10, 0, 10),
              child: Text(
                platform.name,
                style: const TextStyle(
                  color: Color(0xFF969696),
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ],
                color: white,
              ),
              child: Column(
                children: list,
              ),
            ),
          ],
        ));
      }
    }

    body.add(const SizedBox(height: 10));
    return Column(children: body);
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () async {
        bool saveSucceed =
            await BaseConfigRequest.updateDataSource(userDatasourceUuids);
        if (saveSucceed) {
          DunToast.showInfo("保存成功");
          _getUserDatasource(settingData);
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
            color: DunColors.DunColor,
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
