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
  bool loadData = false;
  bool fuckError = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: comicsList.length,
        itemBuilder: (ctx, index) {
          return ComicsCard(comicsList[index]);
        });
  }

  //  获取数据
  _getData() async {
    var data = await ListRequest.canteenCardList(source: {"source": "8"});
    if (data.isNotEmpty) {
      comicsList = data;
      return data;
    } else {
      fuckError = true;
      DunError(error: "哦豁，看不了漫画了");
    }
  }
}
