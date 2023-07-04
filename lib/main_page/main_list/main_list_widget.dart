import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/container_with_label.dart';
import 'package:dun_cookie_flutter/main_page/main_list/ui/main_list_item_card.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/request/cdn_datasource_request.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:dun_cookie_flutter/request/serve_cdn_cookie_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/cookie_main_list_model.dart';
import '../../model/newest_cookie_id_model.dart';
import '../../model/setting_data.dart';
import '../../provider/setting_provider.dart';

class MainListWidget extends StatefulWidget {
  const MainListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainListWidgetState();
}

class _MainListWidgetState extends State<MainListWidget> {
  SettingData? settingData;
  List<Cookies>? data;
  String? nextPageId;
  NewestCookieIdModel? newestCookieId;
  /// 滚动控制器
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    settingData = Provider.of<SettingProvider>(context, listen: false).appSetting;
    fetchData();
    /// 为滚动控制器添加监听
    _scrollController.addListener(() {
      /// _scrollController.position.pixels 是当前像素点位置
      /// _scrollController.position.maxScrollExtent 当前列表最大可滚动位置
      /// 如果二者相等 , 那么就触发上拉加载更多机制
      if (nextPageId != null && _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        /// 触发上拉加载更多机制
        _loadMore();
      }
    });
    super.initState();
  }

  /// 上拉加载更多
  _loadMore() async {
    var cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, nextPageId!, newestCookieId!.updateCookieId);
    data!.addAll(cookiesResp.cookies!);
    nextPageId = cookiesResp.nextPageId;

    setState(() {
    });
  }

  void fetchData() async {
    var newestIdResp = await CdnCookieApi.getCdnNewestCookieId(settingData!.datasourceSetting!.datasourceCombId!);
    newestCookieId = newestIdResp;
    var cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, newestCookieId!.updateCookieId);
    data = cookiesResp.cookies;
    nextPageId = cookiesResp.nextPageId;
    setState(() {});
  }

  /// 下拉刷新回调方法
  Future<Null> _onRefresh() async {
    var newestIdResp = await CdnCookieApi.getCdnNewestCookieId(settingData!.datasourceSetting!.datasourceCombId!);
    if (newestIdResp.updateCookieId == newestCookieId?.updateCookieId && newestIdResp.cookieId == newestCookieId?.cookieId) {
      return null;
    }
    newestCookieId = newestIdResp;
    var cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, newestCookieId!.updateCookieId);
    data = cookiesResp.cookies;
    nextPageId = cookiesResp.nextPageId;

    /// 更新状态
    setState(() {
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          _buildTitleBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: data != null ? ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return MainListItemCard(
                    data: data![index],
                    settingData: settingData,
                  );
                },
                itemCount: data!.length,
              ) : Center(
                child: Image.asset("assets/image/load/loading.gif"),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          const ContainerWithLabel(
            text: "小刻食堂",
            containerWidth: 90,
            labelColor: yellow,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 14,
                  color: gray_1,
                ),
                Expanded(
                  child: Container(
                    color: white,
                  ),
                ),
                Container(
                  width: 44,
                  color: gray_1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
