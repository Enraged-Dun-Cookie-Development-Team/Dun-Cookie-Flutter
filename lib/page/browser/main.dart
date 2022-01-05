import 'dart:io';
import 'package:dun_cookie_flutter/provider/view_webpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DunWebView extends StatelessWidget {
  DunWebView(url, {Key? key}) : super(key: key);

  late String url;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewWebPageProvider(),
      child: DunWebViewMain(url),
    );
  }
}

class DunWebViewMain extends StatefulWidget {
  DunWebViewMain(url, {Key? key}) : super(key: key);

  late String url;

  @override
  State<DunWebViewMain> createState() => _DunWebViewMainState();
}

class _DunWebViewMainState extends State<DunWebViewMain> {
  late WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Consumer<ViewWebPageProvider>(
            builder: (ctx, data, child) {
              return Text(data.title);
            },
          ),
        ),
        body: Consumer<ViewWebPageProvider>(
          builder: (ctx, data, child) {
            return WebView(
              initialUrl: widget.url,
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
      ),
    );
  }
}
