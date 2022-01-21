import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/page/home/dun_buttom_navigation_bar.dart';
import 'package:dun_cookie_flutter/page/info/open_screen_info.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/service/info_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatefulWidget {
  MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  BuildContext? _context;

  _init() async {}

  _checkOpenScreenInfo() async {
    var data = await DunPreferences().getBool(key: "notOnce");
    if (!data) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OpenScreenInfo()));
    }
  }

//  获取info文件并判断文件版本
  _getCeobecanteenInfoAndCheckVersion() async {
    CeobecanteenInfo value = await InfoRequest.getCeobecanteenInfo();
    Provider.of<CeobecanteenInfo>(context, listen: false)
        .setCeobecanteenInfo(value);
    if (value.app!.version != StaticVariable.version) {
      Navigator.pushNamed(context, DunUpdate.routerName, arguments: value.app);
    }
  }

  @override
  void initState() {
    // 初始化全局变量，读取设置
    _init();
    // 是否是第一次进入APP
    _checkOpenScreenInfo();
    // 获取CeobecanteenInfo和判断版本
    _getCeobecanteenInfoAndCheckVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Selector<CommonProvider, Map<String, int>>(
      selector: (ctx, commonProvider) {
        return {
          "routerIndex": commonProvider.routerIndex,
          "themeIndex": commonProvider.themeIndex
        };
      },
      shouldRebuild: (prev, next) => prev != next,
      builder: (ctx, data, child) {
        int routerIndex = data["routerIndex"] as int;
        return Scaffold(
          appBar: _appBar(routerIndex),
          body: DunRouter.pages[routerIndex],
          bottomNavigationBar: DunBottomNavigationBar(),
          floatingActionButton: routerIndex == 0
              ? _floatingActionButton(routerIndex, true)
              : _floatingActionButton(routerIndex, false),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // drawer: const DunDrawer(),
        );
      },
    );
  }

  _floatingActionButton(routerIndex, isActive) {
    return FloatingActionButton(
      backgroundColor: isActive ? DunColors.DunColor : Colors.grey,
      onPressed: () {
        if (routerIndex != 0) {
          Provider.of<CommonProvider>(context, listen: false).setRouterIndex(0);
        }
      },
      child: Image.asset(
        "assets/logo/logo.png",
        width: 34,
      ),
    );
  }

  _appBar(routerIndex) => AppBar(
      title: Text(DunRouter.pageTitles[routerIndex]),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      actions: routerIndex == 2
          ? [
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: '设置',
                onPressed: () {
                  Navigator.pushNamed(_context!, DunSetting.routerName);
                },
              ),
            ]
          : [Container()]);

  _theme(themeIndex) => DunTheme.themeList[themeIndex];
}
