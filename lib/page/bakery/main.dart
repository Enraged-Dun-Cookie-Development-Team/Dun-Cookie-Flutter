import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/page/bakery/bakery_card.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/tool/dun_toast.dart';
import '../../request/bakery_request.dart';

class Bakery extends StatefulWidget {
  Bakery({Key? key}) : super(key: key);
  static String routeName = "/bakery";

  @override
  State<Bakery> createState() => _BakeryState();
}

class _BakeryState extends State<Bakery> {
  _getBakeryInfo(id) async {
    BakeryData value = await BakeryRequest.getBakeryInfo(id);
    if (value.id == null) {
      DunToast.showError("饼组服务器无法连接");
    }
    Provider.of<CommonProvider>(context, listen: false).bakeryData = value;
  }

  _getBakeryMansionIdList() async {
    List<String> value = await BakeryRequest.getBakeryMansionIdList();
    if (value.isEmpty) {
      DunToast.showError("获取大厦列表失败");
    } else {
      eventBus.fire(ChangePopupMenuDownButton(idList: value));
      _getBakeryInfo(value[0].toString());
    }
  }

  @override
  void initState() {
    // 获取饼组列表
    _getBakeryMansionIdList();
    // 监听更新列表
    eventBus.on<ChangePopupMenuDownButton>().listen((event) {
      if (event.checkId != null) {
        _getBakeryInfo(event.checkId!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, BakeryData>(
      builder: (ctx, data, child) {
        return data.id == null ? Container() : BakeryCard(data);
      },
      selector: (ctx, commonProvider) {
        return commonProvider.bakeryData;
      },
    );
  }
}
