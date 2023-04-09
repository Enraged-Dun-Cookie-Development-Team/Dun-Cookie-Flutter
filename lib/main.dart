import 'dart:io';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main_page/main_list/main_list_widget.dart';
import 'package:dun_cookie_flutter/main_page/more_list/more_list_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/terminal_page_widget.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:provider/provider.dart';

import 'provider/common_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  if (Platform.isIOS) {
    MobpushPlugin.setCustomNotification();

    // 开发环境 false, 线上环境 true
    MobpushPlugin.setAPNsForProduction(true);
  }
  runApp(const CeobeCanteenApp());
  // runApp(const DunMain());
}

class CeobeCanteenApp extends StatelessWidget {
  const CeobeCanteenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '小刻食堂',
      home: BottomNavBar(),
    );
  }
}

//底部导航栏组件
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNaacBarState createState() => _BottomNaacBarState();
}

class _BottomNaacBarState extends State<BottomNavBar> {
  //点击导航时显示指定内容
  List<Widget> list = [const MoreListWidget(), const MainListWidget(), const TerminalPageWidget()];
  //当前点击的导航下标
  int _currentController = 1;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    double paddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      //页面显示的主体内容
      body: Container(
        color: gray_3,
        padding: EdgeInsets.only(top: paddingTop),
        child: list[_currentController],
      ),
      //浮动按钮代替中间导航按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () => setState(() => _currentController = 1),
        child: Container(
          width: 83,
          height: 83,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: yellow,
              width: 2,
            ),
            color: yellow,
          ),
          child: Center(
            child: Image.asset(
              'assets/icon/main_list_icon.png',
              width: 57,
              height: 48,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //当前选中的导航栏
        currentIndex: _currentController,
        //点击导航栏触发的事件
        onTap: (int index) {
          setState(() {
            _currentController = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/more_list_icon.png',
                width: 30,
                height: 30,
              ),
              label: "更多"),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/terminal_page_icon.png',
                width: 30,
                height: 30,
              ),
              label: "终端"),
        ],
      ),
    );
  }
}

class DunMain extends StatefulWidget {
  const DunMain({Key? key}) : super(key: key);

  @override
  State<DunMain> createState() => _DunMainState();
}

class _DunMainState extends State<DunMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
          ChangeNotifierProvider<SettingProvider>(create: (_) => SettingProvider()),
          ChangeNotifierProvider<CeobecanteenData>(create: (_) => CeobecanteenData()),
        ],
        child: Consumer<SettingProvider>(builder: (context, settingModeProvider, _) {
          ThemeMode? themeMode;

          if (settingModeProvider.appSetting.darkMode == 1) {
            themeMode = ThemeMode.light;
          } else if (settingModeProvider.appSetting.darkMode == 2) {
            themeMode = ThemeMode.dark;
          } else {
            themeMode = null;
          }
          return MaterialApp(
            title: "小刻食堂",
            routes: DunRouter.routes,
            builder: (ctx, child) {
              return child!;
            },
            theme: DunTheme.themeList[0],
            darkTheme: DunTheme.darkThemeList[0],
            themeMode: themeMode,
            onUnknownRoute: (settings) =>
                MaterialPageRoute(builder: (context) => DunError(error: "404")),
            initialRoute: "/",
          );
        }));
  }
}
