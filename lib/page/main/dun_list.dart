import 'package:dun_cookie_flutter/common/init/main.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/app_bar_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_card_item.dart';
import 'package:dun_cookie_flutter/page/main/dun_loading.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/service/list_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  void initState() {
    super.initState();
    // 清除30天前的图片缓存
    clearDiskCachedImages(duration: const Duration(days: 30));
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   DunInit().showCookieNotification();
    // });
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, List<SourceData>>(
      builder: (context, sourceDataList, child) {
        return SmartRefresher(
          header: const DunLoading(),
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
    await _getDate();
    _refreshController.refreshCompleted();
  }

  //  获取数据
  _getDate() async {
    // List<SourceData> newList = await ListRequest.canteenNewCardList();
    // if (newList.length != 0) {
    //   DunToast.showSuccess("找到了${newList.length}个新饼");
    // }
    // Provider.of<CommonProvider>(context, listen: false)
    //     .addListInSourceData(newList);
    var provider = Provider.of<CommonProvider>(context, listen: false);
    await provider.checkSourceInPreferences();
    var data = await ListRequest.canteenCardList(
        source: {"source": provider.checkSource.join("_")});
    provider.sourceData = data;
    return data;
  }
}
