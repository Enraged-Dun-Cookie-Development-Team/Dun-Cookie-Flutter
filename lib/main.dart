import 'dart:io';


import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dunApp.dart';
import 'manager/dunPreference.dart';
import 'manager/settingManager.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  earlyInit().then((_) => runApp(const DunApp()));
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
  await DunPreferences.getInstance().init();
  await SettingManager.getInstance().init();
  await FkUserAgent.init();
}
