import 'dart:io';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/dialog/InfoDialog.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:provider/provider.dart';

import '../../common/constant/main.dart';
import '../../dialog/ToSettingDialog.dart';
import '../../model/user_settings.dart';
import '../../request/info_request.dart';

class OpenScreenInfo extends StatefulWidget {
  const OpenScreenInfo({Key? key}) : super(key: key);

  @override
  State<OpenScreenInfo> createState() => _OpenScreenInfoState();
}

class _OpenScreenInfoState extends State<OpenScreenInfo> {
  @override
  void initState() {
    _initMobPush();
  }

  /// 注册mobid，并且与后端注册
  _initMobPush() async {
    await MobpushPlugin.updatePrivacyPermissionStatus(true);
    eventBus.fire(UpdatePrivacyPermissionStatus());

    if (Platform.isIOS) {
      MobpushPlugin.setCustomNotification();
      // 开发环境 false, 线上环境 true
      MobpushPlugin.setAPNsForProduction(true);
    }

    //获取注册的设备id， 这个可以不初始化
    Map<String, dynamic> ridMap = await MobpushPlugin.getRegistrationId();
    String regId = ridMap['res'].toString();

    print('RID: ' + regId);
    Constant.mobRId = regId;
  }

  _registerMobPush(SettingProvider settingData) async {
    var regId = Constant.mobRId;
    if (settingData.appSetting.rid != regId) {
      settingData.saveRid(regId);
    }
    print('MobID: ' + regId!);
    var success = false;
    var retry = 0;
    while (true) {
      success = await InfoRequest.createUser(regId);
      if (success) {
        break;
      }
      retry += 1;
      if (retry > 5) {
        break;
      }
      var duration = const Duration(seconds: 1);
      await Future.delayed(duration);
    }
    UserDatasourceSettings userSettings =
        await InfoRequest.getUserDatasourceSettings();
    settingData.saveDatasourceSetting(userSettings);
  }

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
            title: const Text("产品声明与用户协议提示"),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            // width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  width: 100,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "欢迎您使用小刻食堂移动端",
                  style: DunStyles.text20C,
                ),
                Text(
                  "请允许推送与连接网络权限",
                  style: DunStyles.text14C.copyWith(color: Colors.red),
                ),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.w200,
                          color: DunColors.DunColorGrey),
                      children: [
                        const TextSpan(
                            text:
                                "为了您的体验，请您务必审慎阅读、充分理解我们的“产品声明”与“用户守则”条款。您可阅读"),
                        TextSpan(
                          text: "《产品声明》",
                          style: const TextStyle(color: DunColors.DunColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (_) => InfoDialog(
                                        title: "《产品声明》",
                                        content:
                                            "本产品为非商业化产品，除捐助用于服务器运行资金外无任何收益。\n\n本产品仅供学习交流使用。\n\n本产品相关内容（文字、图片、音视频等）均来源于/转自第三方，平台转载相关内容不视为对于相关内容、观点的认可，亦不视为对于相关内容的真实性、准确性、完整性、合法性做出任何承诺。相关内容的真实合法性由内容发布者自行承担，本平台不承担相关法律责任。本平台已明确提示内容来源，如相关内容侵犯了您的合法权益，您亦需联系发布源进行处理。\n\n来自于第三方网站的链接，系由平台根据您的搜索需求或为向您提供便利而提供或设置，外部链接指向的不由本平台实际控制的任何网页上的内容，本平台不承担任何责任。您可能从该第三方网站上获得资讯及享用服务，本平台网无法控制第三方提供的内容、服务的质量、安全或合法性、信息的真实性或准确性。您应自行谨慎判断确定，并自行承担因此产生的责任与损失。除非本平台另有明确规定，若您对于第三方网站或链接有任何异议，您应联系第三方网站的内容或链接提供者处理。\n\n如若侵犯第三方权益，请您及时与我们联系，我们将立刻整改。",
                                      ));
                            },
                        ),
                        const TextSpan(text: "和"),
                        TextSpan(
                          text: "《用户守则》",
                          style: TextStyle(color: DunColors.DunColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (_) => InfoDialog(
                                        title: "《用户守则》",
                                        content:
                                            "欢迎使用由小刻食堂开发团队（以下简称「开发组」）开发的「小刻食堂」系列。在您使用本框架之前，请仔细阅读并完全理解本声明。一旦您开始使用小刻食堂，即表示您同意遵守本声明中的所有条款和条件。\n\n1. 使用目的： 小刻食堂是一个免费开源的软件项目，旨在为用户提供抓取B站、微博、明日方舟通讯组等API数据的功能，并提供多种实用功能，如实时饼消息通知、快速跳转链接、饼内容分享、详细内容查看、饼内容图片生成、理智回复时间计算等。\n\n2. 合法合理使用： 您承诺以合法、合理的方式使用小刻食堂，不得将其用于任何违法、侵权或其他恶意行为，也不得将其应用于违反当地法律法规的Web平台。\n\n3. 免责声明： 开发组对于因使用小刻食堂而引起的任何意外、疏忽、合同损害、诽谤、版权或知识产权侵权以及由此产生的损失（包括但不限于直接、间接、附带或衍生的损失等）不承担任何法律责任。\n\n4. 风险承担： 用户明确同意，使用小刻食堂所存在的风险和后果将完全由用户自行承担，开发组不承担任何法律责任。\n\n5. 合法发布和使用： 用户在遵守本声明的前提下，可在《MIT开源许可证》所允许的范围内合法地发布、传播和使用小刻食堂。对于因违反本声明或法律法规造成的法律责任（包括但不限于民事赔偿和刑事责任），将由违约者自行承担。\n\n6. 知识产权： 小刻食堂及其相关产品享有开发组的知识产权保护，包括但不限于商标权、专利权、著作权、商业秘密等，受相关法律法规保护。\n\n7. 条款变更： 开发组有权随时单方面修改本声明条款及附件内容，并通过消息推送、网页公告等方式进行公布。变更后的条款在公布后立即生效，用户继续使用即表示您已充分阅读、理解并接受修改后的声明内容。\n\n8. 隐私政策：此项目引用了MobSDK进行推送\n\n请在使用小刻食堂之前仔细阅读并理解本声明。如果您有任何疑问，请咨询相关法律专业人士。感谢您的合作与支持！",
                                      ));
                            },
                        ),
                        const TextSpan(text: "了解详细信息。如您同意，请点击“同意并继续”开始接受我们的服务。")
                      ]),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: "不同意",
                    style: TextStyle(color: gray_1),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        exit(0);
                      },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(DunColors.DunColor),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 40)),
                    ),
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        await showDialog(
                            context: this.context,
                            barrierDismissible: false,
                            builder: (_) => ToSettingDialog());
                      }
                      Navigator.of(context).pop(true);
                      DunToast.showInfo("与土豆服务器连接中……");
                      var settingData =
                      Provider.of<SettingProvider>(context, listen: false);
                      await _registerMobPush(settingData);
                      settingData.appSetting.notOnce = false;
                      settingData.saveAppSetting();
                    },
                    child: const Text(
                      "同意并继续",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
