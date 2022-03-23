import 'package:animations/animations.dart';
import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/device_info.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/app_bar_Data.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
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
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatefulWidget {
  MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  _init() async {
    // 初始化推送变量
    await _initJPush();
    // 初始化监听事件
    await _initEventBus();
    // 是否是第一次进入APP
    await _checkOpenScreenInfo();
    // 第一次打开APP 全部拉一次数据
    await _getData();
    // 获取CeobecanteenInfo和判断版本
    await _getCeobecanteenInfoAndCheckVersion();
    // 获取饼组信息
    await _getBakeryInfo();
  }

  _initEventBus() async {
    // 获取设备ID
    eventBus.on<ChangeSourceBus>().listen((event) {
      _getData();
    });
  }

  _initJPush() async {
    JPush jpush = new JPush();
    jpush.setup(
      appKey: Constant.jpushAppKey,
      channel: "flutter_channel",
      production: false,
    );
    Constant.jpushRid = await jpush.getRegistrationID();
    print(Constant.jpushRid);
    setState(() {
      Constant.jpushRid = Constant.jpushRid;
    });
  }

  _getData() async {
    var provider = Provider.of<CommonProvider>(context, listen: false);
    await provider.checkSourceInPreferences();
    provider.sourceData = await ListRequest.canteenCardList(
        source: {"source": provider.checkSource.join("_")});
  }

  _checkOpenScreenInfo() async {
    var data = await DunPreferences().getBool(key: "notOnce");
    if (!data) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OpenScreenInfo()));
    }
  }

//  获取info文件并判断文件版本
  _getCeobecanteenInfoAndCheckVersion() async {
    CeobecanteenData value = await InfoRequest.getCeobecanteenInfo();
    Provider.of<CeobecanteenData>(context, listen: false)
        .setCeobecanteenInfo(value);
    if (value.app == null) {
      DunToast.showError("资源服务器无法连接，无法工具页部分信息");
    } else {
      if (double.parse(value.app!.version!) > double.parse(Constant.version)) {
        Navigator.pushNamed(context, DunUpdate.routerName,
            arguments: value.app);
      }
    }
  }

  _getBakeryInfo() async {
    BakeryData value = await BakeryRequest.getBakeryInfo();
    if (value.title == null) {
      DunToast.showError("饼组服务器无法连接");
    }
    Provider.of<CommonProvider>(context, listen: false)
        .addListInBakeryData(value);
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
                    IconButton(
                      icon: const Icon(Icons.add_to_home_screen),
                      tooltip: '前往B站空间',
                      onPressed: () {
                        OpenAppOrBrowser.openUrl(
                            "https://m.bilibili.com/space/8412516", context,
                            appUrlScheme: "bilibili://space/8412516");
                      },
                    ),
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
                      onTap: () => {
                        Provider.of<CommonProvider>(context, listen: false)
                            .setRouterIndex(index),
                        Navigator.pop(context)
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: DunRouter.pages[routerIndex],
        );
      },
    );
  }
}
