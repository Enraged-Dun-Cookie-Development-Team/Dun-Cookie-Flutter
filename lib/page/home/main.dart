import 'package:dun_cookie_flutter/common/pubilc.dart';
import 'package:dun_cookie_flutter/page/home/dun_buttom_navigation_bar.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/provider/list_source_info_provider.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({Key? key}) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListSourceInfoProvider>(
            create: (_) => ListSourceInfoProvider()),
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
      ],
      child: Consumer<CommonProvider>(
        builder: (ctx, data, child) {
          return Theme(
            data: _theme(data),
            child: Scaffold(
              appBar: _appBar(data),
              body: DunRouter.pages[data.routerIndex],
              bottomNavigationBar: DunBottomNavigationBar(),
              floatingActionButton: data.routerIndex == 0
                  ? _floatingActionButton("assets/logo/logo.png", data, true)
                  : _floatingActionButton(
                      "assets/logo/logo@noactive.png", data, false),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              // drawer: const DunDrawer(),
            ),
          );
        },
      ),
    );
  }

  _floatingActionButton(url, CommonProvider data, isActive) {
    return FloatingActionButton(
      backgroundColor: isActive ? DunColors.DunColor : Colors.white,
      onPressed: () {
        if (data.routerIndex != 0) {
          data.setRouterIndex(0);
        }
      },
      child: Image.asset(
        url,
        width: 34,
      ),
    );
  }

  _appBar(CommonProvider data) => AppBar(
        title: Text(DunRouter.pageTitles[data.routerIndex]),
      );

  _theme(CommonProvider data) => DunTheme.themeList[data.themeIndex];
}
