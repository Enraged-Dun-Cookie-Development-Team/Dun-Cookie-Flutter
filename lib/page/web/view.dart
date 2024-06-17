import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/dun_color.dart';
import 'logic.dart';

class WebPage extends StatelessWidget {
  WebPage({Key? key}) : super(key: key);

  final logic = Get.put(WebLogic());
  final state = Get.find<WebLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //背景颜色
        backgroundColor: Colors.white,
        //左侧按钮
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: logic.onTapBack,
        ),
        //按钮宽度
        leadingWidth: 50,
        //按钮样式
        iconTheme: const IconThemeData(
          color: DunColors.DunColor,
        ),
        //文字样式
        titleTextStyle:
            const TextStyle(color: DunColors.DunColor, fontSize: 20),
        //文字和按钮间距
        titleSpacing: 0,
        title: Obx(() => Text(state.title.value)),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: WebViewWidget(
        controller: state.webController,
      ),
    );
  }
}
