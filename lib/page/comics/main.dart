import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/comics/comicsCard.dart';
import 'package:dun_cookie_flutter/page/error/main.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/request/list_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comics extends StatefulWidget {
  const Comics({Key? key}) : super(key: key);
  static String routerName = "/comics";

  @override
  State<Comics> createState() => _ComicsState();
}

class _ComicsState extends State<Comics> {
  List<SourceData> comicsList = [];

  //  加载状态 0一切正常 1正在加载 2加载失败
  int loadDataType = 0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loadDataType == 0
        ? ListView.builder(
            itemCount: comicsList.length,
            itemBuilder: (ctx, index) {
              return ComicsCard(comicsList[index]);
            })
        : loadDataType == 1
            ? const Center(
                child: Text("这是精美的加载动画"),
              )
            : GestureDetector(
                onTap: () {
                  _getData();
                },
                child: const Center(
                  child: Text("这是难受的报错动画"),
                ),
              );
  }

  //  获取数据
  _getData() async {
    setState(() {
      loadDataType = 1;
    });
    var data = await ListRequest.canteenCardList(source: {"source": "8"});
    if (data.isNotEmpty) {
      setState(() {
        comicsList = data;
        loadDataType = 0;
      });
    } else {
      setState(() {
        loadDataType = 2;
      });
      DunError(error: "漫画服务器断开");
    }
  }
}
