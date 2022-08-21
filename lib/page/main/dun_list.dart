import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_card_item.dart';
import 'package:dun_cookie_flutter/page/main/dun_loading.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, List<SourceData>?>(
      builder: (context, sourceDataList, child) {
        return SmartRefresher(
          header: const DunLoading(),
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: checkListHasValue(sourceDataList),
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

  bool isAllowRefresh = true;

  void _onRefresh() async {
    if (isAllowRefresh) {
      await _getData();
      isAllowRefresh = false;
      Future.delayed(const Duration(seconds: 10), () {
        isAllowRefresh = true;
      });
      _refreshController.refreshCompleted();
    } else {
      DunToast.showError("阿伟，休息一下吧");
      _refreshController.refreshCompleted();
    }
  }

  //  获取数据
  _getData() async {
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    var data = await ListRequest.canteenCardList(
        source: {"source": settingData.appSetting.checkSource!.join("_")});
    var provider = Provider.of<CommonProvider>(context, listen: false);
    provider.sourceData = data;
    return data;
  }

  // 根据列表调整显示内容
  // data == null 初始化
  // data == [] 数据库连接失败
  checkListHasValue(sourceDataList) {
    if (sourceDataList != null && sourceDataList.length > 0) {
      return ListView.builder(
        itemCount: sourceDataList.length,
        itemBuilder: (ctx, index) {
          var info = sourceDataList[index];
          return DunCardItem(
            info: info,
            index: index,
          );
        },
      );
    } else if (sourceDataList == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/image/load/loading.gif"),
              width: 120,
            ),
            Text("等待食堂数据……"),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/image/load/error.png"),
              width: 120,
            ),
            Text("哦豁！服务器炸了"),
          ],
        ),
      );
    }
  }
}
