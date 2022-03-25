import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DunUpdate extends StatelessWidget {
  const DunUpdate({Key? key}) : super(key: key);

  static String routerName = "/update";

  isFocusUpdate(DunApp dunApp) {
    final List<int> nowVersion =
        dunApp.version!.split(".").map((a) => int.parse(a)).toList();
    final List<int> pastVersion =
        Constant.version.split(".").map((a) => int.parse(a)).toList();
    final List<int> lastVersion =
        dunApp.lastFocusVersion!.split(".").map((a) => int.parse(a)).toList();

    // 判断现在Version
    for (var i = 0; i < nowVersion.length; i++) {
      if (nowVersion[i] > pastVersion[i]) {
        if (dunApp.update!) {
          return true;
        } else {
          break;
        }
      } else if (nowVersion[i] < pastVersion[i]) {
        return false;
      }
    }

    // 判断lastFocusVersion
    for (var i = 0; i < nowVersion.length; i++) {
      if (lastVersion[i] > pastVersion[i]) {
        return true;
      } else if (lastVersion[i] < pastVersion[i]) {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final DunApp dunApp = ModalRoute.of(context)!.settings.arguments as DunApp;
    bool isFocus = isFocusUpdate(dunApp);

    return WillPopScope(
      onWillPop: () async {
        if (isFocus) {
          DunToast.showInfo("这波啊，是强制更新");
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isFocus ? false : true,
          title: const Text("[公告]不停机客户端更新公告"),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(text: "感谢您对《小刻食堂》的关注与支持。《小刻食堂》将于现在进行服务器不停机的"),
                    TextSpan(
                        text: "客户端更新", style: TextStyle(color: Colors.red)),
                    TextSpan(
                        text: "。本次更新不会影响博士正常蹲饼进程，更新结束后，博士只需选择合适时间打开软件即可完成更新。")
                  ], style: TextStyle(color: Colors.black)),
                ),
                _content("版本升级",
                    "${Constant.version} --> ${dunApp.version.toString()}"),
                _content("更新时间", "现在"),
                _content("更新模式", isFocus ? "强制" : "非强制",
                    color: isFocus ? Colors.red : Colors.black),
                _content("更新内容", dunApp.description),
                _content("更新补偿：虚空合成玉*300", "补偿范围：更新前所有小刻食堂用户"),
                _content("更新地址", "没钱买服务器，请在群里面找群文件"),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: '362860473'));
                    DunToast.showSuccess("已复制，来QQ群找我们升级吧！");
                  },
                  child: Text(
                    "群号：362860473，点击复制",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _content(title, content, {Color color = Colors.black}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
