import 'package:animations/animations.dart';
import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/device_info.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/app_bar_Data.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/page/donate/main.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/page/home/home_body.dart';
import 'package:dun_cookie_flutter/page/info/open_screen_info.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/router/router.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/request/bakery_request.dart';
import 'package:dun_cookie_flutter/request/info_request.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatefulWidget {
  MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  _init() async {
    // 初始化监听事件
    _initEventBus();
    // 初始化设置
    _readData();
  }

  List<PopupMenuItem<String>> bakeryPopupButtonList = [];
  String bakeryPupopButton = "";

  _initEventBus() {
    // 获取设备ID
    eventBus.on<ChangeSourceBus>().listen((event) {
      _getData();
    });
    // 获取设备ID
    eventBus.on<ChangeMenu>().listen((event) {
      _getMenu();
    });
    // 同意隐私授权后执行
    eventBus.on<UpdatePrivacyPermissionStatus>().listen((event) async {
      await _initMobPush();
      _readData();
    });
    // 动态改变饼组下拉数据
    eventBus.on<ChangePopupMenuDownButton>().listen((event) {
      if (event.idList != null) {
        bakeryPopupButtonList = [];
        for (var element in event.idList!) {
          bakeryPopupButtonList.add(
            PopupMenuItem<String>(
              value: element,
              child: Text(
                element,
                style: const TextStyle(color: DunColors.DunColor),
              ),
            ),
          );
        }
        setState(() {
          bakeryPopupButtonList = bakeryPopupButtonList;
          bakeryPupopButton = bakeryPopupButtonList[0].value!;
        });
      }
    });
  }

  _readData() async {
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    await settingData.readAppSetting();
    Constant.mobRId = settingData.appSetting.rid;
    if (settingData.appSetting.notOnce!) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OpenScreenInfo()));
    } else {
      // 打开APP 全部拉一次数据
      await _getData();
      // 获取CeobecanteenInfo和判断版本
      await _getCeobecanteenInfoAndCheckVersion();
      // 动态菜单
      await _getMenu();

      // 推送变量
      _initMobPush();
    }
  }

  _initMobPush() async {
    //获取注册的设备id， 这个可以不初始化
    Map<String, dynamic> ridMap = await MobpushPlugin.getRegistrationId();
    String regId = ridMap['res'].toString();
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    if (settingData.appSetting.rid != regId) {
      settingData.saveRid(regId);
    }
    print('RID: ' + regId);
    setState(() {
      Constant.mobRId = regId;
    });
  }

  _getData() async {
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    var commonProvider = Provider.of<CommonProvider>(context, listen: false);
    commonProvider.sourceData = await ListRequest.canteenCardList(
        source: {"source": settingData.appSetting.checkSource!.join("_")});
    // commonProvider.saveListSourceData(commonProvider.sourceData!);
  }

//  获取info文件并判断文件版本
  _getCeobecanteenInfoAndCheckVersion() async {
    CeobecanteenData value = await InfoRequest.getCeobecanteenInfo();
    Provider.of<CeobecanteenData>(context, listen: false)
        .setCeobecanteenInfo(value);
    if (value.app == null) {
      DunToast.showError("资源服务器无法连接");
    } else {
      if (double.parse(value.app!.version!) > double.parse(Constant.version)) {
        Navigator.pushNamed(context, DunUpdate.routerName,
            arguments: value.app);
      }
    }
  }

  List<QuickJump> shortcutMenu = [];

  _getMenu() async {
    shortcutMenu = [];
    CeobecanteenData ceobecanteenData =
        Provider.of<CeobecanteenData>(context, listen: false).ceobecanteenInfo!;
    var settingProvider = Provider.of<SettingProvider>(context, listen: false);
    var shortcutList = settingProvider.appSetting.shortcutList;
    if (ceobecanteenData.quickJump != null) {
      for (var element in ceobecanteenData.quickJump!) {
        if (shortcutList!.contains(element.name)) {
          shortcutMenu.add(element);
        }
      }
    }
    setState(() {
      shortcutMenu = shortcutMenu;
    });
  }

  @override
  void initState() {
    // 初始化全局变量，读取设置
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, int>(
      selector: (ctx, commonProvider) {
        return commonProvider.routerIndex;
      },
      shouldRebuild: (prev, next) => prev != next,
      builder: (ctx, routerIndex, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [Text(DunRouter.pageTitles[routerIndex])],
            ),
            actions: routerIndex == 1
                ? [
                    // IconButton(
                    //   icon: const Icon(Icons.add_to_home_screen),
                    //   tooltip: '前往B站空间',
                    //   onPressed: () {
                    //     OpenAppOrBrowser.openUrl(
                    //         "https://m.bilibili.com/space/8412516", context,
                    //         appUrlScheme: "bilibili://space/8412516");
                    //   },
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton(
                          itemBuilder: (ctx) {
                            return bakeryPopupButtonList;
                          },
                          icon: const Icon(Icons.restore_page),
                          initialValue: bakeryPupopButton,
                          tooltip: "切换其他大厦",
                          onSelected: (value) {
                            setState(() {
                              bakeryPupopButton = value.toString();
                            });
                            DunToast.showSuccess("获取大厦${value.toString()}");
                            eventBus.fire(ChangePopupMenuDownButton(
                                checkId: bakeryPupopButton));
                          },
                        ),
                      ],
                    )
                  ]
                : null,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: DunColors.DunColor,
                  ),
                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage("assets/logo/logo_no_line.png"),
                        width: 100,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '小刻食堂 Bate V' + Constant.version,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(
                    DunRouter.pageTitles.length,
                    (index) => ListTile(
                      leading: DunRouter.pagesIcon[index],
                      title: Text(DunRouter.pageTitles[index]),
                      onTap: () {
                        Provider.of<CommonProvider>(context, listen: false)
                            .setRouterIndex(index);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const Divider(
                  height: 6.0,
                  indent: 0.0,
                  color: DunColors.DunColor,
                ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.monetization_on,
                //     size: 30,
                //     color: DunColors.DunColor,
                //   ),
                //   title: const Text("捐助"),
                //   onTap: () {
                //     Navigator.pushNamed(context, Donate.routerName);
                //     // Navigator.pop(context);
                //   },
                // ),
                // const Divider(
                //   height: 6.0,
                //   indent: 0.0,
                //   color: DunColors.DunColor,
                // ),
                Column(
                  children: shortcutMenu.isEmpty
                      ? [
                          const Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("在线第三方工具内长按添加快捷进入"),
                            ),
                          )
                        ]
                      : List.generate(
                          shortcutMenu.length,
                          (index) => ListTile(
                            leading: Image(
                              image: AssetImage(shortcutMenu[index].img),
                              width: 30,
                            ),
                            title: Text(shortcutMenu[index].name),
                            onTap: () {
                              Navigator.pop(context);
                              OpenAppOrBrowser.openUrl(
                                  shortcutMenu[index].url, context);
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
          body: WillPopScope(
              onWillPop: () async {
                // 设置的话 退回到主页
                if (routerIndex == 3) {
                  Provider.of<CommonProvider>(context, listen: false)
                      .setRouterIndex(0);
                  return false;
                } else {
                  return doubleClickBack();
                }
              },
              child: DunRouter.pages[routerIndex]),
        );
      },
    );
  }

  int last = 0;

  // 连续按两次退出  未实现
  Future<bool> doubleClickBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 1000) {
      last = DateTime.now().millisecondsSinceEpoch;
      DunToast.showSuccess("再按一次退出");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
