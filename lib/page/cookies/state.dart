import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';

class CookiesState {
  List<Cookie> cookieList = []; //饼列表
  String? nextPageId; //下一页ID

  List<Cookie> searchCookieList = []; //搜索数据
  String? searchNextPageId; //搜索数据下一页ID

  NewestCookieIdModel newestCookieId = NewestCookieIdModel.fromJson({}); //最新饼id

  bool isAllowRefresh = true; // 运行刷新

  bool searchStatue = false; // 搜索状态
  String lastSearchContent = '';
  RxBool offstage = true.obs; // 隐藏搜索清空
  ///监听TextField内容变化
  final TextEditingController searchController = TextEditingController();

  /// 滚动控制器
  ScrollController scrollController = ScrollController();
  /// 滚动控制器
  final FocusNode searchFocusNode = FocusNode();

  String listGID = "listGID";

  CookiesState() {
    ///Initialize variables
  }
}
