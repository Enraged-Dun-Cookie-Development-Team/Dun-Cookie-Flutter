import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/page/home/dun_buttom_navigation_bar.dart';
import 'package:dun_cookie_flutter/page/home/open_screen_info.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:dun_cookie_flutter/page/update_dialog/main.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatefulWidget {
  MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  BuildContext? _context;

  _checkOpenScreenInfo() async {
    var data = await DunPreferences().getBool(key: "notOnce");
    if (!data) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OpenScreenInfo()));
    }
  }

  @override
  void initState() {
    // 是否是第一次进入APP
    _checkOpenScreenInfo();
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
        return Theme(
          data: _theme(data["themeIndex"]),
          child: Scaffold(
            appBar: _appBar(data["routerIndex"]),
            body: DunRouter.pages[data["routerIndex"]!],
            bottomNavigationBar: DunBottomNavigationBar(),
            floatingActionButton: data["routerIndex"] == 0
                ? _floatingActionButton(
                    "assets/logo/logo.png", ctx, data["routerIndex"], true)
                : _floatingActionButton("assets/logo/logo@noactive.png", ctx,
                    data["routerIndex"], false),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // drawer: const DunDrawer(),
          ),
        );
      },
    );
  }

  _floatingActionButton(url, BuildContext ctx, routerIndex, isActive) {
    return FloatingActionButton(
      backgroundColor: isActive ? DunColors.DunColor : Colors.white,
      onPressed: () {
        if (routerIndex != 0) {
          Provider.of<CommonProvider>(ctx, listen: false).setRouterIndex(0);
        }
      },
      child: Image.asset(
        url,
        width: 34,
      ),
    );
  }

  _appBar(routerIndex) => AppBar(
      title: Text(DunRouter.pageTitles[routerIndex]),
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

  _updateDialog(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () async {
      var result = await showUpdateDialog(context);
      if (result == null) {
        print("取消删除");
      } else {
        print("已确认删除");
      }
    });
  }
}
