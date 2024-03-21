import 'package:animate_do/animate_do.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/page/honey_cake_workshop/ui/honey_cake_workshop_card.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:dun_cookie_flutter/request/bakery_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HoneyCakeWorkshopPage extends StatefulWidget {
  const HoneyCakeWorkshopPage({Key? key}) : super(key: key);
  static String routeName = "/honey_cake_workshop_page";

  @override
  State<HoneyCakeWorkshopPage> createState() => _HoneyCakeWorkshopPageState();
}

class _HoneyCakeWorkshopPageState extends State<HoneyCakeWorkshopPage> {
  //  加载状态 0一切正常 1正在加载 2加载失败
  int loadDataType = 0;

  List<String> bakeryMansionIdList = [];

  _getBakeryInfo(String? id) async {
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
    bakeryMansionIdList = await BakeryRequest.getBakeryMansionIdList();
    if (bakeryMansionIdList.isEmpty) {
      setState(() {
        loadDataType = 2;
      });
      DunToast.showError("获取大厦列表失败");
    } else {
      setState(() {
        loadDataType = 0;
      });
      eventBus.fire(ChangePopupMenuDownButton(idList: bakeryMansionIdList));
      _getBakeryInfo(bakeryMansionIdList.last);
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
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: gray_3,
          appBar: AppBar(
            //蜜饼工坊页面
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => {Navigator.of(context).pop('刷新')}),
            leadingWidth: 50,
            iconTheme: const IconThemeData(
              color: DunColors.DunColor,
            ),
            titleTextStyle:
                const TextStyle(color: DunColors.DunColor, fontSize: 20),
            titleSpacing: 0,
            title: const Text("罗德岛蜜饼工坊"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: bakeryMansionIdList.isNotEmpty
                    ? SizedBox(
                        width: 80,
                        // 下拉列表框选版本
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: DunColors.DunColor, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: DunColors.DunColor, width: 1.5)),
                          ),
                          value: bakeryMansionIdList.last,
                          // 选择回调
                          onChanged: (String? value) => _getBakeryInfo(value),
                          // 传入可选的数组
                          items: bakeryMansionIdList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: Selector<CommonProvider, BakeryData>(
                    builder: (ctx, data, child) {
                  if (loadDataType == 2) {
                    return GestureDetector(
                      onTap: () => _getBakeryMansionIdList(),
                      child: const Center(
                        child: Image(
                          image:
                              AssetImage("assets/image/load/bakery_error.png"),
                          width: 200,
                        ),
                      ),
                    );
                  }
                  return loadDataType == 1
                      ? const Center(
                          child: Image(
                            image: AssetImage(
                                "assets/image/load/bakery_loading.gif"),
                            width: 200,
                          ),
                        )
                      : FadeIn(
                          duration: const Duration(milliseconds: 1000),
                          child: HoneyCakeWorkshopCard(data));
                }, selector: (ctx, commonProvider) {
                  return commonProvider.bakeryData;
                }),
              ),
              _buildBottomButton(),
            ],
          )),
        ));
  }

  Widget _buildBottomButton() {
    return GestureDetector(
      onTap: () {
        OpenAppOrBrowser.openUrl(
            "https://m.bilibili.com/space/8412516", context,
            appUrlScheme: "bilibili://space/8412516");
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: DunColors.DunColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                image: AssetImage("assets/image/bilibili_up_mbgf.webp"),
                height: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "前往 罗德岛蜜饼工坊 的B站空间",
              style: TextStyle(
                color: white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
