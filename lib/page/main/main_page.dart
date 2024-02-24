import 'dart:async';
import 'dart:io';

import 'package:dun_cookie_flutter/page/main/terminal/terminal_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Dialog/UpdataDialog.dart';
import '../../common/constant/main.dart';
import '../../common/tool/color_theme.dart';
import '../../common/tool/package_info.dart';
import '../../dialog/TapStarDialog.dart';
import '../../dialog/UpdataInfoDialog.dart';
import '../../model/ceobecanteen_data.dart';
import '../../model/setting_data.dart';
import '../../provider/setting_provider.dart';

import '../../request/info_request.dart';
import '../screeninfo/open_screen_info.dart';
import 'home/main_list_widget.dart';
import 'more/more_list_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String routeName = "/";

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 当前子项索引
  int currentIndex = 0;

  // 控制器
  late PageController _controller;

  @override
  void initState() {
    _readData();
    _controller = PageController();
    super.initState();
  }

  _readData() async {
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    Constant.mobRId = settingData.appSetting.rid;
    bool? notOnce = settingData.appSetting.notOnce;
    if (notOnce!) {
      bool result = false;
      final completer = Completer<bool>();
      // 延迟到下一帧执行
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OpenScreenInfo()))
            .then((value) => completer.complete(value));
      });
      result = await completer.future;
      if (!result) return null;
      //申请权限
      Permission.notification.request();
    } else {
      if (Platform.isIOS) {
        MobpushPlugin.setCustomNotification();
        // 开发环境 false, 线上环境 true
        MobpushPlugin.setAPNsForProduction(true);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        settingData.flash();
      });
    }
    _checkVersion();
  }

  // 判断版本号，强制更新&更新日志
  _checkVersion() async {
    String nowVersion = await PackageInfoPlus.getVersion();
    DunApp newApp = await InfoRequest.getAppVersionInfo();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? lastShowedVersion = sp.getString("update_dialog_showed_version");
    if (Platform.isIOS) {
      int? openNumber = sp.getInt("number_of_openings");
      if (openNumber != null) {
        if (openNumber > 0) {
          sp.setInt("number_of_openings", openNumber + 1);
        }
        if (openNumber == 10) {
          showDialog(context: context, builder: (_) => TapStartDialog());
          // 先不用重置 统计一下吧
          // sp.setInt("number_of_openings",-1);
        }
      } else {
        sp.setInt("number_of_openings", 1);
      }
    }
    if (lastShowedVersion != null && nowVersion != lastShowedVersion) {
      DunApp nowApp = await InfoRequest.getAppVersionInfo(version: nowVersion);
      showDialog(
          context: context,
          builder: (_) => UpdataInfoDialog(
                version: nowApp.version,
                description: nowApp.description,
              ));
      sp.setString("update_dialog_showed_version", nowVersion);
    }
    if (PackageInfoPlus.isVersionHigher(newApp.lastForceVersion, nowVersion)) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => UpdataDialog(
                oldVersion: nowVersion,
                newApp: newApp,
                isFocus: true,
              ));
    } else if (PackageInfoPlus.isVersionHigher(newApp.version, nowVersion)) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => UpdataDialog(
                oldVersion: nowVersion,
                newApp: newApp,
                isFocus: false,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          body: Container(
              color: gray_3,
              padding: EdgeInsets.only(top: paddingTop),
              child: Stack(
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    // 设置控制器
                    controller: _controller,
                    // 设置子项集
                    children: [
                      MainListWidget(),
                      MoreListWidget(),
                      TerminalPageWidget()
                    ],
                  ),
                  ..._buildBottomBar(),
                ],
              ))),
    );
  }

  List<Widget> _buildBottomBar() {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: REdgeInsets.only(bottom: paddingBottom),
          height: 60.h + paddingBottom,
          decoration: const BoxDecoration(color: white, boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0.0, 0.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            )
          ]),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    currentIndex = 1;
                    _controller.jumpToPage(currentIndex);
                  }),
                  child: Image.asset(
                    'assets/icon/more_list_icon.png',
                    width: 30.r,
                    height: 30.r,
                    color: currentIndex == 1 ? yellow : gray_2,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    currentIndex = 2;
                    _controller.jumpToPage(currentIndex);
                  }),
                  child: Image.asset(
                    'assets/icon/terminal_page_icon.png',
                    width: 30.r,
                    height: 30.r,
                    color: currentIndex == 2 ? yellow : gray_2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
          padding: EdgeInsets.only(bottom: paddingBottom),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => setState(() {
                currentIndex = 0;
                _controller.jumpToPage(currentIndex);
              }),
              child: Container(
                width: 83.r,
                height: 83.r,
                margin: REdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50).r,
                  border: Border.all(
                    color: currentIndex == 0 ? yellow : gray_2,
                    width: 2.r,
                  ),
                  color: currentIndex == 0 ? yellow : white,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icon/main_list_icon.png',
                    width: 57.r,
                    height: 48.r,
                    color: currentIndex == 0 ? white : gray_2,
                  ),
                ),
              ),
            ),
          ))
    ];
  }
}
