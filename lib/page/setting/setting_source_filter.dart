import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: List.generate(list.length, (index) {
            String priority = list[index].priority.toString();
            return ListTile(
                title: Text(list[index].title),
                leading: Image.asset(
                  list[index].icon,
                  width: 30,
                ),
                trailing: Switch(
                  value: CommonProvider().checkSource.contains(priority),
                  onChanged: (value) {
                    CommonProvider().setCheckListInPriority(priority, value);
                  },
                ));
          }),
        ),
      ),
    );
  }
}
