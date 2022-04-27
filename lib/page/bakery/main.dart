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
  //  加载状态 0一切正常 1正在加载 2加载失败
  int loadDataType = 0;

  _getBakeryInfo(id) async {
    setState(() {
      loadDataType = 1;
    });
    BakeryData value = await BakeryRequest.getBakeryInfo(id);
    if (value.id == null) {
      setState(() {
        loadDataType = 2;
      });
      DunToast.showError("饼组服务器无法连接");
    } else {
      setState(() {
        loadDataType = 0;
      });
      Provider.of<CommonProvider>(context, listen: false).bakeryData = value;
    }
  }

  _getBakeryMansionIdList() async {
    setState(() {
      loadDataType = 1;
    });
    List<String> value = await BakeryRequest.getBakeryMansionIdList();
    if (value.isEmpty) {
      setState(() {
        loadDataType = 2;
      });
      DunToast.showError("获取大厦列表失败");
    } else {
      setState(() {
        loadDataType = 0;
      });
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
        Provider.of<CommonProvider>(context, listen: false).bakeryData =
            BakeryData();
        _getBakeryInfo(event.checkId!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CommonProvider, BakeryData>(builder: (ctx, data, child) {
      if (loadDataType == 2) {
        return GestureDetector(
          onTap: () {
            _getBakeryMansionIdList();
          },
          child: const Center(
            child: Image(
              image: AssetImage("assets/image/load/bakery_error.png"),
              width: 200,
            ),
          ),
        );
      }
      return loadDataType == 1
          ? const Center(
              child: Image(
                image: AssetImage("assets/image/load/bakery_loading.gif"),
                width: 200,
              ),
            )
          : FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: BakeryCard(data));
    }, selector: (ctx, commonProvider) {
      return commonProvider.bakeryData;
    });
  }
}
