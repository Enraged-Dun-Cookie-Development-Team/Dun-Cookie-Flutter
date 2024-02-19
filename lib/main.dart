import 'dart:async';
import 'dart:io';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/package_info.dart';
import 'package:dun_cookie_flutter/page/error/main.dart';
import 'package:dun_cookie_flutter/page/main/home/main_list_widget.dart';
import 'package:dun_cookie_flutter/page/main/more/more_list_widget.dart';
import 'package:dun_cookie_flutter/page/main/terminal/terminal_page_widget.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/page/screeninfo/open_screen_info.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/request/info_request.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dialog/UpdataDialog.dart';
import 'common/constant/main.dart';
import 'dialog/TapStarDialog.dart';
import 'dialog/UpdataInfoDialog.dart';
import 'provider/common_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  earlyInit().then((_) => runApp(const CeobeCanteenApp()));
}

Future<void> earlyInit() async {
  //沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 状态栏颜色设置为透明
      statusBarIconBrightness: Brightness.dark, // 状态栏图标文字颜色设置为黑色
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  await SettingProvider.getInstance().readAppSetting();

  await FkUserAgent.init();
}

class CeobeCanteenApp extends StatefulWidget {
  const CeobeCanteenApp({Key? key}) : super(key: key);

  @override
  State<CeobeCanteenApp> createState() => _CeobeCanteenAppState();
}

class _CeobeCanteenAppState extends State<CeobeCanteenApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
        ChangeNotifierProvider.value(value: SettingProvider.getInstance()),
        ChangeNotifierProvider<CeobecanteenData>(
            create: (_) => CeobecanteenData()),
      ],
      child: MaterialApp(
        title: '小刻食堂',
        routes: DunRouter.routes,
        initialRoute: "/",
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => DunError(error: "404"),
        ),
      ),
    );
  }
}


