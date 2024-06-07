import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import 'logic.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key}) : super(key: key);

  final logic = Get.put(UpdateLogic());
  final state = Get.find<UpdateLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GetBuilder<UpdateLogic>(
          id: state.rootGID,
          builder: (UpdateLogic controller) {
            return WillPopScope(
              onWillPop: logic.onWillBack,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: logic.onTapBack,
                  ),
                  iconTheme: const IconThemeData(
                    color: DunColors.DunColor,
                  ),
                  centerTitle: true,
                  titleTextStyle:
                      const TextStyle(color: DunColors.DunColor, fontSize: 20),
                  title: const Text("检查更新"),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("assets/logo/logo_no_line.png"),
                              width: 50,
                            ),
                            const SizedBox(width: 13),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "当前版本",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  state.nowVersion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _content("新版本", state.version),
                        _content("更新模式", state.isFocus ? "强制" : "非强制",
                            color: state.isFocus ? Colors.red : Colors.black),
                        _content("更新内容", state.description),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "更新地址",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _downloadRes(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  _content(title, content, {Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  _downloadRes() {
    if (Platform.isAndroid) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _downloadButton("github", state.dunAppInfo.apk),
            _downloadButton("kgithub", state.dunAppInfo.spareApk),
            _downloadButton("百度云", state.dunAppInfo.baidu),
          ],
        ),
      );
    } else if (Platform.isIOS) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)))),
                backgroundColor: MaterialStateProperty.all(DunColors.DunColor),
              ),
              onPressed: () => logic.onTapDownload(
                  'https://apps.apple.com/cn/app/id1629917304', true),
              child: const Text(
                "应用商店",
              ),
            )
          ],
        ),
      );
    }
  }

  _downloadButton(address, url) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
        backgroundColor: MaterialStateProperty.all(DunColors.DunColor),
      ),
      onPressed: () => logic.onTapDownload(url, false),
      child: Text(
        address,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
