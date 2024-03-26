import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dun_cookie_flutter/page/error/main.dart';

import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';

import 'package:dun_cookie_flutter/provider/setting_provider.dart';

import 'package:dun_cookie_flutter/router/router.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobpush_plugin/mobpush_custom_message.dart';
import 'package:mobpush_plugin/mobpush_notify_message.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';

import 'package:provider/provider.dart';

import 'provider/common_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  earlyInit().then((_) => runApp(const MaterialApp(home: CeobeCanteenApp(),)));
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
  void initState() {
    super.initState();
    //MobpushPlugin.addPushReceiver(_onEvent, _onError);
  }

  // void _onEvent(dynamic event) {
  //   print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onEvent:' + event.toString());
  //   setState(() {
  //     Map<String, dynamic> eventMap = json.decode(event as String);
  //     Map<String, dynamic> result = eventMap['result'];
  //     int action = eventMap['action'];
  //     switch (action) {
  //       case 0://未知
  //         MobPushNotifyMessage message = MobPushNotifyMessage.fromJson(result);
  //         break;
  //       case 1://通知推送
  //         MobPushCustomMessage message = MobPushCustomMessage.fromJson(result);
  //
  //         break;
  //       case 2://点击推送
  //         MobPushNotifyMessage message = MobPushNotifyMessage.fromJson(result);
  //         showDialog(
  //             context: context,
  //             builder: (context) {
  //               return AlertDialog(
  //                 content: Text(message.content),
  //                 actions: <Widget>[
  //                   TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: const Text("确定"))
  //                 ],
  //               );
  //             });
  //         break;
  //     }
  //   });
  // }
  //
  // void _onError(dynamic event) {
  //   setState(() {
  //     print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onError:' + event.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CommonProvider>(
              create: (_) => CommonProvider()),
          ChangeNotifierProvider.value(value: SettingProvider.getInstance()),
          ChangeNotifierProvider<CeobecanteenData>(
              create: (_) => CeobecanteenData()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: '小刻食堂',
                routes: DunRouter.routes,
                initialRoute: "/",
                onUnknownRoute: (settings) => MaterialPageRoute(
                  builder: (context) => DunError(error: "404"),
                ),
              );
            }));
  }
}
