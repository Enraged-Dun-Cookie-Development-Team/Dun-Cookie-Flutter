import 'dart:io' show Platform;
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/provider/view_webpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../tool/color_theme.dart';

class DunWebView extends StatelessWidget {
  static String routeName = "/webView";

  const DunWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider(
      create: (context) => ViewWebPageProvider(),
      child: WillPopScope(
          // 当返回为true时,可以自动返回(flutter帮助我们执行返回操作)
          // 当返回为false时, 自行写返回代码
          // 特殊：iOS 版本需要返回 null，否则会影响 iOS 系统级自动返回
          // https://github.com/flutter/flutter/issues/14203
          onWillPop: Platform.isIOS
              ? null
              : () {
                  return Future.value(true);
                },
          child: DunWebViewMain(url)),
    );
  }
}

class DunWebViewMain extends StatefulWidget {
  const DunWebViewMain(this.url, {Key? key}) : super(key: key);

  final String url;

  @override
  State<DunWebViewMain> createState() => _DunWebViewMainState();
}

class _DunWebViewMainState extends State<DunWebViewMain> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //友站链接
        backgroundColor: Colors.white,//背景颜色
        leading: IconButton(//左侧按钮
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.of(context).pop('刷新')}),
        leadingWidth: 50,//按钮宽度
        iconTheme: const IconThemeData(//按钮样式
          color: DunColors.DunColor,
        ),
        titleTextStyle://文字样式
        const TextStyle(color: DunColors.DunColor, fontSize: 20),
        titleSpacing: 0,//文字和按钮间距

        title: Consumer<ViewWebPageProvider>(
          builder: (ctx, data, child) {
            return Text(data.title);
          },
        ),

        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Consumer<ViewWebPageProvider>(
        builder: (ctx, data, child) {
          return WebView(
            initialUrl: widget.url,
            navigationDelegate: (request) {
              if (request.url.startsWith('bilibili://') ||
                  request.url.startsWith('weibo://') ||
                  request.url.startsWith('orpheus://')) {
                if(Platform.isIOS && request.url.startsWith('weibo://')) {
                  request.url.replaceFirst('weibo', 'sinaweibo');
                }
                OpenAppOrBrowser.openAppUrlScheme(request.url, context);
                Navigator.pop(context);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              data.setUrl(url);
            },
            onProgress: (progress) {
              data.setTitle("小刻努力奔跑中……${progress.toString()}%");
            },
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onPageFinished: (url) {
              data.setSuccess(true);
              _controller.runJavascriptReturningResult("document.title").then(
                (result) {
                  data.setTitle(result.replaceAll("\"", ""));
                },
              );
            },
          );
        },
      ),
    );
  }
}
