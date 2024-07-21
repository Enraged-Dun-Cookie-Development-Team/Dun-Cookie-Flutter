import 'dart:io';

import 'package:dun_cookie_flutter/common/dun_dialog.dart';
import 'package:dun_cookie_flutter/manager/settingManager.dart';
import 'package:dun_cookie_flutter/widget/lazy_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/dun_color.dart';
import '../common/package_info.dart';
import '../manager/dunPreference.dart';
import '../model/ceobe/version/dun_app.dart';
import '../request/ceobe/ceobe_request.dart';
import 'cookies/view.dart';
import 'more/view.dart';
import 'terminal/view.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // 当前子项索引
  int currentIndex = 0;

  //主页
  List<Widget> pageList = [
    const CookiesPage(),
    const MorePage(),
    const TerminalPage(),
  ];

  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  // 判断版本号，强制更新&更新日志
  _checkVersion() async {
    String nowVersion = SettingManager.getInstance().version;
    DunAppInfoModel? newApp = await CeobeApi.getAppVersionInfo();
    String? lastShowedVersion = getLastShowVersion();
    if (Platform.isIOS) {
      int openNumber = getLaunchCount() ?? 0;
      if (openNumber >= 0) {
        saveLaunchCount(openNumber + 1);
      }
      if (openNumber == 10) {
        showTapStarDialog();
        // 先不用重置 统计一下吧
        // sp.setInt("number_of_openings",-1);
      }
    }
    if (lastShowedVersion != null && nowVersion != lastShowedVersion) {
      DunAppInfoModel? nowApp =
          await CeobeApi.getAppVersionInfo(version: nowVersion);
      if (nowApp != null) {
        showUpdateInfoDialog(nowApp);
      }
    }
    if (newApp != null) {
      if (PackageInfoPlus.isVersionHigher(
          newApp.version, nowVersion)) {
        showUpdateDialog(
            nowAppVersion: nowVersion, newApp: newApp, isFocus: newApp.force);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          body: Container(
              color: DunColors.gray_3,
              padding: EdgeInsets.only(top: paddingTop),
              child: Stack(
                children: [
                  LazyIndexedStack(
                    index: currentIndex,
                    // 设置子项集
                    children: pageList,
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
          padding: EdgeInsets.only(bottom: paddingBottom),
          height: 60 + paddingBottom,
          decoration: const BoxDecoration(color: DunColors.white, boxShadow: [
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
                  }),
                  child: Image.asset(
                    'assets/icon/more_list_icon.png',
                    width: 30,
                    height: 30,
                    color:
                        currentIndex == 1 ? DunColors.yellow : DunColors.gray_2,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    currentIndex = 2;
                  }),
                  child: Image.asset(
                    'assets/icon/terminal_page_icon.png',
                    width: 30,
                    height: 30,
                    color:
                        currentIndex == 2 ? DunColors.yellow : DunColors.gray_2,
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
              }),
              child: Container(
                width: 83,
                height: 83,
                margin: REdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color:
                        currentIndex == 0 ? DunColors.yellow : DunColors.gray_2,
                    width: 2,
                  ),
                  color: currentIndex == 0 ? DunColors.yellow : DunColors.white,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icon/main_list_icon.png',
                    width: 57,
                    height: 48,
                    color:
                        currentIndex == 0 ? DunColors.white : DunColors.gray_2,
                  ),
                ),
              ),
            ),
          ))
    ];
  }
}
