import 'package:dun_cookie_flutter/cache/setting_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool? checkedBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("傻逼"),
      ),
      body: Column(
        children: [
          Selector<SettingCache, SettingCache>(
            builder: (ctx, data, child) {
              return Checkbox(
                  value: data.isShowShabi,
                  onChanged: (value) {
                    setState(() {
                      data.isShowShabi = value!;
                    });
                  });
            },
            selector: (ctx, ctx2) => ctx2,
            shouldRebuild: (pre, next) => false,
          ),
          Consumer<SettingCache>(builder: (ctx, data, child) {
            return Text("传来的值${data.isShowShabi.toString()}");
          })
        ],
      ),
    );
  }
}
