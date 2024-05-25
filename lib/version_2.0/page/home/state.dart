import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';

class HomeState {
  List<Cookie> data = []; //饼列表
  String? nextPageId; //下一页ID

  List<Cookie> searchData = []; //搜索数据
  String? searchNextPageId; //搜索数据下一页ID

  NewestCookieIdModel? newestCookieId; //最新饼id

  bool searchStatue = false; // 搜索状态
  RxBool offstage = true.obs; // 隐藏搜索清空
  bool isAllowRefresh = true; // 运行刷新

  String listGID = "listGID";

  /// 滚动控制器
  ScrollController scrollController = ScrollController();

  ///监听TextField内容变化
  final TextEditingController searchController = TextEditingController();

  HomeState() {
    ///Initialize variables
  }
}
