import 'package:dun_cookie_flutter/model/bilibili_user_favlist_data.dart';
import 'package:dun_cookie_flutter/page/error/main.dart';
import 'package:dun_cookie_flutter/page/user_Wan/userWanCard.dart';
import 'package:dun_cookie_flutter/request/user_request.dart';
import 'package:flutter/material.dart';

import '../../common/tool/open_app_or_browser.dart';

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
    return Column(
      children: [
        Expanded(
          child: loadDataType == 0
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
                    ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                OpenAppOrBrowser.openUrl(
                    "https://m.bilibili.com/space/1579053316", context,
                    appUrlScheme: "bilibili://space/1579053316");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      image:
                          AssetImage("assets/image/bilibili_up_wanwanzi.webp"),
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  const Text("数据来源：Wan顽子 的B站动态"),
                ],
              )),
        ),
      ],
    );
  }

  //  获取数据
  _getFavListData() async {
    setState(() {
      loadDataType = 1;
    });
    var data = await UserRequest.getUserFavlist(1579053316);
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
