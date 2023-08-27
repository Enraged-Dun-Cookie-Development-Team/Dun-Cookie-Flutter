import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/component/group_num_button.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/tool/color_theme.dart';
import '../../common/tool/package_info.dart';

class DunUpdate extends StatefulWidget {
  static String routerName = "/update";

  const DunUpdate({Key? key}) : super(key: key);

  @override
  State<DunUpdate> createState() => _DunUpdateState();
}

class _DunUpdateState extends State<DunUpdate> {
  bool isFocus = false;
  String version = '0.0.0';
  late DunApp dunApp;

  isFocusUpdate(DunApp dunApp) async {
    if (await PackageInfoPlus.isVersionHigherThenNow(dunApp.version) &&
        dunApp.force) {
      return true;
    }
    if (await PackageInfoPlus.isVersionHigherThenNow(dunApp.lastFocusVersion)) {
      return true;
    }
    return false;
  }

  void init() async {
    version = await PackageInfoPlus.getVersion();
    isFocus = await isFocusUpdate(dunApp);
    setState(() {
      version = version;
      isFocus = isFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    dunApp = ModalRoute.of(context)!.settings.arguments as DunApp;
    return WillPopScope(
      onWillPop: () async {
        if (isFocus) {
          DunToast.showInfo("这波啊，是强制更新");
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (isFocus) {
                  DunToast.showInfo("这波啊，是强制更新");
                } else {
                  Navigator.of(context).pop('刷新');
                }
              }),
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
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _content("版本升级", "$version --> ${dunApp.version.toString()}"),
                _content("更新模式", isFocus ? "强制" : "非强制",
                    color: isFocus ? Colors.red : Colors.black),
                _content("更新内容", dunApp.description),
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
                Container(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _DownloadButton("github", ""),
                      _DownloadButton("kgithub", ""),
                      _DownloadButton("百度云", ""),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _content(title, content, {Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
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

  _DownloadButton(address, url) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(DunColors.DunColor),
      ),
      onPressed: () {
        //跳转到更新地址
      },
      child: Text(
        address,
      ),
    );
  }
}
