import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("饼来源"),
      ),
      body: SingleChildScrollView(
        child: Consumer<CommonProvider>(builder: (context, data, child) {
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
                    value: data.checkSource.contains(priority),
                    onChanged: (value) {
                      if (!value && data.checkSource.length == 1) {
                        DunToast.showError("至少关注一个哦");
                      } else {
                        data.setCheckListInPriority(priority, value);
                      }
                    },
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
