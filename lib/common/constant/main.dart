import 'package:flutter/material.dart';

class Constant {
  //  初始路由
  static const int starRouterIndex = 0;

  //  设备ID
  static String? deviceId;

  //  设备RID
  static String? mobRId;

  //  DarkMode: 1-跟随系统 2-常亮 3-常暗
  static const themeModeList = [
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark
  ];

//  设备AppKey
// static String jpushAppKey = "6248b1e12f48c74929e9d0bc";
}
