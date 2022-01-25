import 'dart:io';
import 'package:dun_cookie_flutter/common/init/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'provider/common_provider.dart';

void main() {
  runApp(DunMain());
  //沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  DunInit().initNotifications((result) {
    print(result);
  });
}

class DunMain extends StatefulWidget {
  DunMain({Key? key}) : super(key: key);

  @override
  State<DunMain> createState() => _DunMainState();
}

class _DunMainState extends State<DunMain> {
  int themeIndex = 0;

  @override
  void initState() {
    eventBus.on<ChangeThemeBus>().listen((event) {
      setState(() {
        themeIndex = event.themeIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
        ChangeNotifierProvider<CeobecanteenData>(
            create: (_) => CeobecanteenData()),
      ],
      child: MaterialApp(
        title: "小刻食堂",
        routes: DunRouter.routes,
        theme: DunTheme.themeList[themeIndex],
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => DunError(error: "404")),
        initialRoute: "/",
      ),
    );
  }
}
