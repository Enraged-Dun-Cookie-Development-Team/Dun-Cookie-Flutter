import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingSourceFilter extends StatefulWidget {
  const SettingSourceFilter({Key? key}) : super(key: key);

  static String routerName = "/settingSourceFilter";

  @override
  _SettingSourceFilterState createState() => _SettingSourceFilterState();
}

class _SettingSourceFilterState extends State<SettingSourceFilter> {
  // 获取源数据列表
  List<SourceInfo> list = SourceList.sourceList;

  @override
  void initState() {
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
