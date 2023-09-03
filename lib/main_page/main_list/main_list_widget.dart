import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/container_with_label.dart';
import 'package:dun_cookie_flutter/main_page/main_list/ui/main_list_item_card.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/request/cdn_datasource_request.dart';
import 'package:dun_cookie_flutter/request/cookie_request.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:dun_cookie_flutter/request/serve_cdn_cookie_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/tool/debounce_throttle.dart';
import '../../common/tool/dun_toast.dart';
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
  List<Cookies>? tempData;
  String? tempNextPageId;
  NewestCookieIdModel? newestCookieId;
  bool searchStatue = false; // 搜索状态
  bool offstage = true; // 隐藏搜索清空
  bool isAllowRefresh = true; // 运行刷新
  /// 滚动控制器
  ScrollController _scrollController = ScrollController();
  ///监听TextField内容变化
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    settingData = Provider.of<SettingProvider>(context, listen: false).appSetting;
    fetchData();
    /// 为滚动控制器添加监听

    _scrollController.addListener(() {
      /// _scrollController.position.pixels 是当前像素点位置
      /// _scrollController.position.maxScrollExtent 当前列表最大可滚动位置
      /// 如果二者相等 , 那么就触发上拉加载更多机制
      var debounce = EventFilter.debounce("main_list_page", (){
        if (nextPageId != null && _scrollController.position.maxScrollExtent - _scrollController.position.pixels < 40
            ) {
          /// 触发上拉加载更多机制
          _loadMore();
        }
      },
      duration: const Duration(milliseconds: 200));
      debounce();
    });
    _searchController.addListener(() {
      var debounce = EventFilter.debounce("list_search_word", (){
        bool isNotEmpty = _searchController.text.isNotEmpty;
        if(offstage == isNotEmpty) {
          offstage = !isNotEmpty;
          setState(() {});
        }
        if (!isNotEmpty && searchStatue) {
          _cancelSearch();
        }
      },
      duration: const Duration(milliseconds: 100));
      debounce();
    });
    super.initState();
  }

  /// 上拉加载更多
  _loadMore() async {
    if (searchStatue) {
      var searchText = _searchController.text;
      var cookiesResp = await CookiesApi.getCookieSearchList(settingData!.datasourceSetting!.datasourceCombId!, searchText, nextPageId!);
      data!.addAll(cookiesResp.cookies!);
      nextPageId = cookiesResp.nextPageId;
    } else {
      var cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, nextPageId!, newestCookieId!.updateCookieId);
      data!.addAll(cookiesResp.cookies!);
      nextPageId = cookiesResp.nextPageId;
    }


    setState(() {
    });
  }

  void fetchData() async {
    var newestIdResp = await CdnCookieApi.getCdnNewestCookieId(settingData!.datasourceSetting!.datasourceCombId!);
    newestCookieId = newestIdResp;
    var cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, newestCookieId!.updateCookieId);
    // 如果请求失败，updateId让它为空再请求一次
    if (cookiesResp.cookies == null) {
      cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, null);
      newestCookieId?.updateCookieId = null;
    }
    data = cookiesResp.cookies;
    nextPageId = cookiesResp.nextPageId;
    // FIXME: 不要在这里调用 setState()，因为本函数可能在 build() 开始之前调用，导致异常
    setState(() {});
  }

  /// 下拉刷新回调方法
  Future<void> _onRefresh() async {
    if (isAllowRefresh) {
      await _getRefreshData();
      isAllowRefresh = false;
      Future.delayed(const Duration(seconds: 10), () {
        isAllowRefresh = true;
      });
    } else {
      DunToast.showError("小刻别急！！！");
    }

  }

  /// 下拉刷新获取数据
  Future<void> _getRefreshData() async {
    var newestIdResp = await CdnCookieApi.getCdnNewestCookieId(settingData!.datasourceSetting!.datasourceCombId!);
    if (newestIdResp.updateCookieId == newestCookieId?.updateCookieId && newestIdResp.cookieId == newestCookieId?.cookieId) {
      return;
    }
    newestCookieId = newestIdResp;
    if (searchStatue) {
      var searchText = _searchController.text;
      var cookiesResp = await CookiesApi.getCookieSearchList(settingData!.datasourceSetting!.datasourceCombId!, searchText, null);
      data = cookiesResp.cookies;
      nextPageId = cookiesResp.nextPageId;
      var cookiesMainResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, newestCookieId!.updateCookieId);
      tempData = cookiesMainResp.cookies;
      tempNextPageId = cookiesMainResp.nextPageId;
    } else {
      var cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, newestCookieId!.updateCookieId);
      // 如果请求失败，updateId让它为空再请求一次
      if (cookiesResp.cookies == null) {
        cookiesResp = await ServeCdnCookieApi.getCdnCookieMainList(settingData!.datasourceSetting!.datasourceCombId!, newestCookieId!.cookieId!, null);
        newestCookieId?.updateCookieId = null;
      }
      data = cookiesResp.cookies;
      nextPageId = cookiesResp.nextPageId;
    }


    /// 更新状态
    setState(() {
    });
    return;
  }

  // 处理搜索请求
  void _handleSearch() async {
    var searchText = _searchController.text;
    if (searchText == "") {
      return;
    }
    var cookiesResp = await CookiesApi.getCookieSearchList(settingData!.datasourceSetting!.datasourceCombId!, searchText, null);
    /// 当前不在搜索状态，将主列表值放入临时
    if (!searchStatue) {
      tempData = data;
      tempNextPageId = nextPageId;
    }
    data = cookiesResp.cookies;
    nextPageId = cookiesResp.nextPageId;
    searchStatue = true;

    _scrollController.animateTo(0, duration: const Duration(milliseconds: 1), curve: Curves.linear);
    /// 更新状态
    setState(() {
    });
  }

  void _cancelSearch() {
    data = tempData;
    nextPageId = tempNextPageId;
    searchStatue = false;
    tempData = [];
    tempNextPageId = null;

    _scrollController.animateTo(0, duration: const Duration(milliseconds: 1), curve: Curves.linear);

    /// 更新状态
    setState(() {
    });
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
                  return index == data!.length? (nextPageId == null ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 30),
                      child: Text(
                        "已经没有饼了，小刻很满足！！！",
                        style: TextStyle(color: gray_1),
                      ),
                    ),
                  ) : const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 30),
                      child: Text(
                        "精美的加载动画",
                        style: TextStyle(color: gray_1),
                      ),
                    ),
                  )) : MainListItemCard(
                    data: data![index],
                    settingData: settingData,
                  );
                },
                itemCount: data!.length + 1,

              ): Center(
                child: Image.asset("assets/image/load/loading.gif"),
              ),
            )
          ),
          Container(
            height: 50,
          )
        ],
      ),
    );
  }
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return ListTile(title: Text('$index'));
        },
        childCount: count,
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '搜索：皮肤',
                         ),
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) {
                        _handleSearch();
                      },
                    ),

                  ),
                ),
                Offstage(
                  offstage: offstage,
                  child: GestureDetector(
                    onTap: () => {_searchController.clear()},
                    child: Container(
                      color: white,
                      height: 42,
                      child: Image.asset(
                        "assets/icon/close.png",
                        width: 16,
                        height: 16,
                      ),
                    )
                  ),
                ),
                Container(
                  width: 5,
                  color: white,
                ),
                Container(
                  width: 44,
                  height: 42,
                  color: gray_1,
                  child: GestureDetector(
                    onTap: () => {
                      _handleSearch()
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icon/search.png",
                        color: yellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
