import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/model/bilibili_user_favlist_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/comics/comicsCard.dart';
import 'package:dun_cookie_flutter/page/error/main.dart';
import 'package:dun_cookie_flutter/page/user_Wan/userWanCard.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:dun_cookie_flutter/request/user_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWan extends StatefulWidget {
  const UserWan({Key? key}) : super(key: key);
  static String routerName = "/user_wan";

  @override
  State<UserWan> createState() => _UserWanState();
}

class _UserWanState extends State<UserWan> {
  BilibiliUserFavlistData listData = BilibiliUserFavlistData();

  //  加载状态 0一切正常 1正在加载 2加载失败
  int loadDataType = 0;

  @override
  void initState() {
    _getFavListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loadDataType == 0
        ? ListView.builder(
            itemCount: listData.data?.count,
            itemBuilder: (ctx, index) {
              return UserWanCard(listData.data!.list![index]);
            })
        : loadDataType == 1
            ? const Center(
                child: Text("这是精美的加载动画"),
              )
            : GestureDetector(
                onTap: () {
                  _getFavListData();
                },
                child: const Center(
                  child: Text("这是难受的报错动画"),
                ),
              );
  }

  //  获取数据
  _getFavListData() async {
    setState(() {
      loadDataType = 1;
    });
    var data = await UserRequest.getUserFavlist('1579053316');
    if (data.code == 0) {
      setState(() {
        listData = data;
        loadDataType = 0;
      });
    } else {
      setState(() {
        loadDataType = 2;
      });
      DunError(error: "B站服务器断开");
    }
  }
}
