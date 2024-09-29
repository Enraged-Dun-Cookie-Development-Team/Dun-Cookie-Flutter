import 'dart:io';

import 'package:dun_cookie_flutter/common/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../common/dun_toast.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final logic = Get.put(RegisterLogic());
  final state = Get.find<RegisterLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: WillPopScope(
        onWillPop: () async {
          DunToast.showError("必须同意或不同意哦");
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "产品声明与用户协议提示",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: DunColors.DunColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: Container(
            padding: REdgeInsets.only(left: 50, right: 50),
            // width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.logo.logo.image(
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
                            ..onTap = logic.onTapProductDeclarations,
                        ),
                        const TextSpan(text: "和"),
                        TextSpan(
                          text: "《用户守则》",
                          style: const TextStyle(color: DunColors.DunColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = logic.onTapGuidelines,
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
                    style: const TextStyle(color: DunColors.gray_1),
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
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    minimumSize: MaterialStateProperty.all(const Size(300, 40)),
                  ),
                  onPressed: logic.onAgree,
                  child: const Text(
                    "同意并继续",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
