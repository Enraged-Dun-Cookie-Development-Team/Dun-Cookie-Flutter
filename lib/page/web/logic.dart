import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/dun_jump.dart';
import 'state.dart';

class WebLogic extends GetxController {
  final WebState state = WebState();

  @override
  void onInit() {
    super.onInit();
    state.url = Get.arguments;
  }

  FutureOr<NavigationDecision> navigationDelegate(NavigationRequest request) {
    if (request.url.startsWith('bilibili://') ||
        request.url.startsWith('weibo://') ||
        request.url.startsWith('orpheus://')) {
      if (Platform.isIOS && request.url.startsWith('weibo://')) {
        request.url.replaceFirst('weibo', 'sinaweibo');
      }
      DunJump.openAppUrlScheme(request.url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void onWebViewCreated(WebViewController controller) {
    state.webController = controller;
  }

  Future<void> onProgress(int progress) async {
    if (progress == 100) {
      await Future.delayed(const Duration(milliseconds: 500));
      state.title.value = await state.webController?.getTitle() ?? '';
    } else {
      state.title.value = "小刻努力奔跑中……${progress.toString()}%";
    }
  }

  void onTapBack() {
    Get.back();
  }
}
