import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class DunSetting extends StatelessWidget {
  const DunSetting({Key? key}) : super(key: key);

  static String routerName = "/setting";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DunTheme.themeList[0],
      home: Scaffold(
        appBar: AppBar(
          title: Text("设置"),
        ),
        body: Center(
          child: Text("设置"),
        ),
      ),
    );
  }
}
