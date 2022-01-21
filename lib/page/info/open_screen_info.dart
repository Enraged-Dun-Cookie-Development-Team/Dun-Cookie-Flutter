import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class OpenScreenInfo extends StatelessWidget {
  const OpenScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "小刻食堂",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("这是一则很重要的说明！"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  width: 100,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "首先欢迎你使用小刻食堂移动端",
                  style: TextStyle(fontSize: 20, color: DunColors.DunColor),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "这是一个测试版本，功能不完整，bug也会有，很可怕吗？是的很可怕！所以怕的博士建议卸载APP，当然也没有那么可怕，毕竟当前的功能也就那么点，bug也不会很刺激，至少在开发阶段没见过闪退什么的。",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "这个版本的发布的主要目的是测试服务器的稳定性，注意：当前的版本不包含推送的功能！需要进入APP进行手动下拉刷新查看，剩下的为数不多的功能就自己探索吧！",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "第一次写移动端，请不要催更，因为要打肉鸽，如果有问题，在设置里面有反馈方法",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                const SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                    onPressed: () {
                      DunPreferences()
                          .saveBool(key: "notOnce", value: true)
                          .then((value) => Navigator.pop(context));
                    },
                    child: const Text("我看完了，我要进食堂看看"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
