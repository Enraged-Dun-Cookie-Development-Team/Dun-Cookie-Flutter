import 'dart:io';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/provider/view_webpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DunWebView extends StatelessWidget {
  static String routeName = "/webView";

  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider(
      create: (context) => ViewWebPageProvider(),
      child: WillPopScope(
          // 当返回为true时,可以自动返回(flutter帮助我们执行返回操作)
          // 当返回为false时, 自行写返回代码
          onWillPop: () {
            return Future.value(true);
          },
          child: DunWebViewMain(url)),
    );
  }
}

class DunWebViewMain extends StatefulWidget {
  DunWebViewMain(this.url, {Key? key}) : super(key: key);

  String url;

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
        title: Consumer<ViewWebPageProvider>(
          builder: (ctx, data, child) {
            return Text(data.title);
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
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
