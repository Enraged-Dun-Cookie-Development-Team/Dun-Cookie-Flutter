import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_card_item.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/service/main_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, List<SourceData>>(
      builder: (context, sourceDataList, child) {
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
      },
      selector: (ctx, commonProvider) {
        return commonProvider.sourceData;
      },
      shouldRebuild: (prev, next) {
        return prev != next;
      },
    );
  }

  //  获取数据
  _getDate() async {
    var provider = Provider.of<CommonProvider>(context, listen: false);
    List<String> checkSource = await provider.checkSourceInPreferences();
    provider.sourceData = await MainRequest.canteenCardList(
        source: {"source": checkSource.join("_")});
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    // 持续两秒 先不需要等待
    // await _getDate();
    // await Future.delayed(Duration(milliseconds: 2000), () {});
  }
}
