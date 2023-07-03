import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/user_settings.dart';
import '../request/info_request.dart';

class SetUpDatasource extends StatefulWidget {
  const SetUpDatasource({Key? key}) : super(key: key);

  static String routerName = "/set_up_datasource";

  @override
  _SetUpDatasourceState createState() => _SetUpDatasourceState();
}

class _SetUpDatasourceState extends State<SetUpDatasource> {
  // 获取所有数据源列表列表
  List<String> allDatasouces = SourceList.sourceList;
  // 获取用户数据源
  List<String> userDatasourceUuids = [];

  _getAllDatasource() async {

  }

  _getUserDatasource(SettingProvider settingData) async {
    UserDatasourceSettings userSettings = await InfoRequest.getUserDatasourceSettings();
    settingData.saveDatasourceSetting(userSettings);
    userDatasourceUuids = settingData.appSetting.datasourceSetting!.datasourceConfig!;
  }

  @override
  void initState() async {
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    if (settingData.appSetting.datasourceSetting == null) {
      _getUserDatasource(settingData);
    } else {
      userDatasourceUuids = settingData.appSetting.datasourceSetting!.datasourceConfig!;
    }
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
        body: SingleChildScrollView(
          child: Selector<SettingProvider, List<String>>(
            // 不知道为什么prev 恒等于 next 等个老师傅解释
              shouldRebuild: (prev, next) => true,
              // shouldRebuild: (prev, next) => prev != next,
              builder: (ctx, checkSource, child) {
                return Column(
                  children: List.generate(
                    list.length,
                        (index) {
                      String priority = list[index].priority.toString();
                      return ListTile(
                        title: Text(list[index].title),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            list[index].icon,
                            width: 30,
                          ),
                        ),
                        trailing: Switch(
                          value: checkSource.contains(priority),
                          onChanged: (value) {
                            if (!value && checkSource.length == 1) {
                              DunToast.showError("至少关注一个哦");
                            } else {
                              var settingProvider =
                              Provider.of<SettingProvider>(context,
                                  listen: false);
                              if (value) {
                                // 添加当前
                                settingProvider.appSetting.checkSource!
                                    .add(priority);
                              } else {
                                // 删除当前
                                settingProvider.appSetting.checkSource!
                                    .remove(priority);
                              }
                              settingProvider.saveAppSetting();
                            }
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              selector: (ctx, settingProvider) {
                return settingProvider.appSetting.checkSource!;
              }),
        ),
      ),
    );
  }
}
