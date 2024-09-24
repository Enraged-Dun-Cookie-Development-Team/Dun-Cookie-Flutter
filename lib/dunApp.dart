import 'package:dun_cookie_flutter/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'manager/settingManager.dart';
import 'route.dart';

class DunApp extends StatelessWidget {
  const DunApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: '小刻食堂',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            surfaceTint: Colors.transparent,
          ),
        ),
        initialRoute: SettingManager.getInstance().notOnce
            ? DunRouter.register
            : DunRouter.root,
        getPages: DunRouter.getPages,
        navigatorObservers: [
          routeObserver,
          RouterLogObserver(logger),
        ],
      ),
    );
  }
}
