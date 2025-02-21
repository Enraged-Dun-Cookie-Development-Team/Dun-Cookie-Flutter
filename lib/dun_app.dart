import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/dun_color.dart';
import 'manager/setting_manager.dart';
import 'route.dart';

class DunApp extends StatelessWidget {
  const DunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: '小刻食堂',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: DunColors.dunColor,
            surfaceTint: Colors.transparent,
          ),
        ),
        initialRoute: SettingManager.getInstance().notOnce
            ? DunRouter.register
            : DunRouter.root,
        getPages: DunRouter.getPages,
        navigatorObservers: [
          routeObserver,
        ],
      ),
    );
  }
}
