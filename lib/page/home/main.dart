import 'package:dun_cookie_flutter/page/home/dun_buttom_navigation_bar.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/provider/list_source_info_provider.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListSourceInfoProvider>(
            create: (_) => ListSourceInfoProvider()),
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
      ],
      child: Consumer<CommonProvider>(
        builder: (ctx, data, child) {
          return Scaffold(
            appBar: _appBar,
            body: DunRouter.pages[data.routerIndex],
            bottomNavigationBar: DunBottomNavigationBar(),
            floatingActionButton: data.routerIndex == 0
                ? _floatingActionButton("assets/logo/logo.png", data)
                : _floatingActionButton("assets/logo/logo@noactive.png", data),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            // drawer: const DunDrawer(),
          );
        },
      ),
    );
  }

  _floatingActionButton(url, data) {
    return FloatingActionButton(
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

  final _appBar = AppBar(
    title: Row(
      children: const [
        Text("小刻食堂 alpha"),
      ],
    ),
  );
}
