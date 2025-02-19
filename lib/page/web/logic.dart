import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/dun_jump.dart';
import '../../common/dun_tool.dart';
import '../../manager/setting_manager.dart';
import 'state.dart';

class WebLogic extends GetxController {
  final WebState state = WebState();

  @override
  void onInit() {
    super.onInit();
    state.url = Get.arguments;
    state.webController = WebViewController()
      ..loadRequest(Uri.parse(state.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: navigationDelegate,
          onProgress: onProgress,
          onPageFinished: onPageFinished,
          onUrlChange: onUrlChange,
        ),
      );
  }

  void onTapBack() {
    Get.back();
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

  Future<void> onProgress(int progress) async {
    if (progress >= 100) {
      await Future.delayed(const Duration(milliseconds: 500));
      state.title.value = await state.webController.getTitle() ?? '';
    } else {
      state.title.value = "小刻努力奔跑中……${progress.toString()}%";
    }
  }

  Future<void> onPageFinished(String url) async {}

  Future<void> onUrlChange(UrlChange change) async {
    String? url = change.url;
    if (url != null) {
      RegExpMatch? match = MangaTool.regExp.firstMatch(url);
      if (match != null) {
        String? comic = match.group(1);
        String? episode = match.group(2);
        if (comic != null && episode != null) {
          SettingManager.getInstance().addMangaHistory(comic, episode);
        }
      }
    }
  }
}
