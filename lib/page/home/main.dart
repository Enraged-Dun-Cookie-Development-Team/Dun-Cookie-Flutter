import 'package:animations/animations.dart';
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

class _MainScaffoldState extends State<MainScaffold>
    with SingleTickerProviderStateMixin {
  BuildContext? _context;

  // late AnimationController _animationController;
  // late Animation<Color> _animation;

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
    // 动画
    // _animationController = AnimationController(
    //     duration: const Duration(milliseconds: 500), vsync: this);
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
          body: PageTransitionSwitcher(
            reverse: routerIndex == 1 ? true : false,
            // reverse: flag,//可以不设置，作用是控制动画方向是否反转，值为true为正向，false为反向，可以根据情况改变此值让动画效果更合理，
            child: DunRouter.pages[routerIndex],
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation, secondaryAnimation) =>
                SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: routerIndex == 0
                        ? SharedAxisTransitionType.scaled
                        : SharedAxisTransitionType.horizontal),
          ),
          bottomNavigationBar: DunBottomNavigationBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                routerIndex == 0 ? DunColors.DunColor : Colors.grey,
            onPressed: () {
              if (routerIndex != 0) {
                Provider.of<CommonProvider>(context, listen: false)
                    .setRouterIndex(0);
              }
            },
            child: Image.asset(
              "assets/logo/logo.png",
              width: 34,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // drawer: const DunDrawer(),
        );
      },
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
