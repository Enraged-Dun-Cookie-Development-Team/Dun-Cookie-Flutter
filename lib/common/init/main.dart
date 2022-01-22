import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DunInit {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initSystemUiOverlayStyle() {
    // 沉浸式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  initNotifications(onSelectNotification) async {
    // 初始化本地推送
    var android = const AndroidInitializationSettings('@mipmap/logo');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  showCookieNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('DunCookie', '饼推送',
            channelDescription: '这个推送只会推送官方饼信息',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        '小刻蹲到新饼啦！',
        '【浊酒澄心】//老鲤“我家的雇员承蒙罗德岛照顾了，他们没给诸位添什么麻烦吧？对了，这是事务所的名片，您收好。”',
        platformChannelSpecifics,
        payload: '回调的值');
  }
}
