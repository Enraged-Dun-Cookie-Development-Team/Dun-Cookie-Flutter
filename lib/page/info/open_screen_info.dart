import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:provider/provider.dart';

class OpenScreenInfo extends StatelessWidget {
  const OpenScreenInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DunToast.showError("必须同意或不同意哦");
        return false;
      },
      child: MaterialApp(
        theme: DunTheme.themeList[0],
        title: "小刻食堂",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("这是一则很重要的说明！"),
            systemOverlayStyle: SystemUiOverlayStyle.light,
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
                    style: DunStyles.text20C,
                  ),
                  Text(
                    "权限方面请允许我们推送和连接网络",
                    style: DunStyles.text14C.copyWith(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "这是一个测试版本，功能不完整，bug也会有，很可怕吗？是的很可怕！所以怕的博士建议卸载APP，当然也没有那么可怕，毕竟当前的功能也就那么点，bug也不会很刺激，至少在开发阶段没见过闪退什么的。",
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "这个版本的发布的主要目的是测试服务器的稳定性，注意：当前的版本不包含推送的功能！需要进入APP进行手动下拉刷新查看，剩下的为数不多的功能就自己探索吧！",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "第一次写移动端，请不要催更，如果有问题，在设置里面有反馈方法",
                    style: DunStyles.text14C.copyWith(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var settingData =
                            Provider.of<SettingProvider>(context, listen: false);
                        settingData.appSetting.notOnce = false;
                        settingData.saveAppSetting();
                        DunToast.showInfo("与土豆服务器连接中……");
                        MobpushPlugin.updatePrivacyPermissionStatus(true).then((value) {
                          eventBus.fire(UpdatePrivacyPermissionStatus());
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("我看完并同意免责声明的内容")),
                  const SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text("我不同意")),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("以下是免责声明"),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                      "1、一切移动客户端用户在下载并浏览小刻食堂软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式使用本APP，或直接、间接使用本APP资料者，均被视为自愿接受本网站相关声明和用户服务协议的约束。\n2、小刻食堂转载的内容并不代表小刻食堂之意见及观点，也不意味着赞同其观点或证实其内容的真实性。\n3、小刻食堂转载的文字、图片、音视频等资料均由鹰角网络与部分信息发布者提供，其真实性、准确性和合法性由信息发布人负责。小刻食堂不提供任何保证，并不承担任何法律责任。\n4、小刻食堂所转载的文字、图片、音视频等资料，如果侵犯了第三方的知识产权或其他权利，未保证数据不被篡改，本APP不会进行任何处理，请联系发布源进行修改。\n5、小刻食堂不保证为向用户提供便利而设置的外部链接的准确性和完整性，同时，对于该外部链接指向的不由小刻食堂实际控制的任何网页上的内容，小刻食堂不承担任何责任。\n6、用户明确并同意其使用小刻食堂网络服务所存在的风险将完全由其本人承担;因其使用小刻食堂网络服务而产生的一切后果也由其本人承担，小刻食堂对此不承担任何责任。\n7、除小刻食堂注明之服务条款外，其它因不当使用本APP而导致的任何意外、疏忽、合约毁坏、诽谤、版权或其他知识产权侵犯及其所造成的任何损失，小刻食堂概不负责，亦不承担任何法律责任。\n8、对于因不可抗力或因黑客攻击、通讯线路中断等小刻食堂不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用小刻食堂，小刻食堂不承担任何责任，但将尽力减少因此给用户造成的损失或影响。\n9、本声明未涉及的问题请参见国家有关法律法规，当本声明与国家有关法律法规冲突时，以国家法律法规为准。\n10、本网站相关声明版权及其修改权、更新权和最终解释权均属小刻食堂所有。"),
                  const Text("此项目引用了MobSdk")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
