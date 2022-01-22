import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_card_item.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/service/main_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DunList extends StatefulWidget {
  const DunList({Key? key}) : super(key: key);
  static String routeName = "/dunList";

  @override
  State<DunList> createState() => _DunListState();
}

class _DunListState extends State<DunList> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // 清除30天前的图片缓存
    clearDiskCachedImages(duration: const Duration(days: 30));
    // 初始化本地推送
    var android = const AndroidInitializationSettings('@mipmap/logo_newyear');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      print(payload);
    });
    _getDate();
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   _showNotification();
    // });
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String headerStr = "后期有好看的动画，监修中……";

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, List<SourceData>>(
      builder: (context, sourceDataList, child) {
        return SmartRefresher(
          header: BezierHeader(
            child: Center(
              child: Text(
                headerStr,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            onModeChange: (mode) {
              // switch (mode) {
              //   case RefreshStatus.idle:
              //     setState(() {
              //       headerStr = "小刻躁动起来了";
              //     });
              //     break;
              //   case RefreshStatus.canRefresh:
              //     setState(() {
              //       headerStr = "按不住了！快来帮忙！";
              //     });
              //     break;
              //   case RefreshStatus.refreshing:
              //     setState(() {
              //       headerStr = "她冲出去了！";
              //     });
              //     break;
              //   case RefreshStatus.completed:
              //     setState(() {
              //       headerStr = "她进食堂了！";
              //     });
              //     break;
              // }
            },
          ),
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: sourceDataList.isEmpty
              ? const Center(
                  child: Text("等待食堂数据……"),
                )
              : ListView.builder(
                  itemCount: sourceDataList.length,
                  itemBuilder: (ctx, index) {
                    var info = sourceDataList[index];
                    return DunCardItem(
                      info: info,
                      index: index,
                    );
                  },
                ),
        );
      },
      selector: (ctx, commonProvider) {
        return commonProvider.sourceData;
      },
      shouldRebuild: (prev, next) {
        return prev != next;
      },
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await _getDate();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  //  获取数据
  _getDate() async {
    var provider = Provider.of<CommonProvider>(context, listen: false);
    List<String> checkSource = await provider.checkSourceInPreferences();
    provider.sourceData = await MainRequest.canteenCardList(
        source: {"source": checkSource.join("_")});
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('DunCookie', '饼推送',
            channelDescription: '这个推送只会推送官方饼信息',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        '小刻蹲到新饼啦！',
        '【浊酒澄心】//老鲤“我家的雇员承蒙罗德岛照顾了，他们没给诸位添什么麻烦吧？对了，这是事务所的名片，您收好。”',
        platformChannelSpecifics,
        payload: '回调的值');
  }
}
