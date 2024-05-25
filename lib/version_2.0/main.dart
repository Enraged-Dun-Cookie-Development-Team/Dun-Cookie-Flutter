import 'dart:io';

import 'package:dun_cookie_flutter/version_2.0/manager/settingManager.dart';
import 'package:dun_cookie_flutter/version_2.0/page/rootPage.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  earlyInit().then((_) => runApp(const MaterialApp(home: CeobeCanteenApp())));
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
  await SettingManager.getInstance().readNotOnce();
  await FkUserAgent.init();
}

class CeobeCanteenApp extends StatefulWidget {
  const CeobeCanteenApp({Key? key}) : super(key: key);

  @override
  State<CeobeCanteenApp> createState() => _CeobeCanteenAppState();
}

class _CeobeCanteenAppState extends State<CeobeCanteenApp> {
  late bool notOnce;

  @override
  void initState() {
    super.initState();
    notOnce = SettingManager.getInstance().notOnce.value;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: '小刻食堂',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                surfaceTint: Colors.transparent,
              ),
              useMaterial3: true,
            ),
            home: const RootPage(),
          );
        });
  }
}
