import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show Image, ImageByteFormat, window;

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

import 'cookie_head.dart';
import 'cookie_share_image.dart';
import 'expandable_text.dart';

class CookieWidgetToImage extends StatefulWidget {
  const CookieWidgetToImage({Key? key}) : super(key: key);
  static String routeName = "/cookieWidgetToImage";

  @override
  State<CookieWidgetToImage> createState() => _CookieWidgetToImageState();
}

class _CookieWidgetToImageState extends State<CookieWidgetToImage> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Cookies sourceData =
        ModalRoute.of(context)!.settings.arguments as Cookies;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("小刻分享"),
        actions: [
          _button(_widgetToImageSave, Icons.save_alt),
          _button(_widgetToImageShare, Icons.share)
        ],
        elevation: 0,
        backgroundColor: const Color(0xFF333333),
      ),
      body: Container(
        color: const Color(0xFF333333),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                color: const Color(0xFF333333),
                width: size.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo/logo_no_line_share.png",
                      width: 60,
                    ),
                    Card(
                      margin: const EdgeInsets.only(top: 0),
                      elevation: 15.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      semanticContainer: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 卡片头
                          SizedBox(
                            height: 131,
                            width: size.width,
                            child: _stackHear(sourceData),
                          ),
                          _buildContent(context, sourceData),
                          // 卡片图片
                          CookieShareImage(data: sourceData, type: 1),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "-- 搜索小刻食堂下载软件 --",
                      style: DunStyles.text14C.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _stackHear(Cookies sourceData) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 二维码
        sourceData.item?.url != null
            ? Positioned(
                right: 5,
                top: 5,
                child: SizedBox(
                  height: 120,
                  child: QrImageView(
                      data: sourceData.item!.url!,
                      version: QrVersions.auto,
                      gapless: false,
                      foregroundColor: DunColors.DunColor),
                ),
              )
            : Container(),
        // 小刻食堂标题
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                    text: "小刻食堂",
                    style: DunStyles.text20C,
                    children: [
                      TextSpan(
                        text: " 移动版",
                        style: DunStyles.text14C,
                      ),
                    ]),
              ),
            ),
            // 小刻食堂标题和下面的分界线
            Container(
              height: 3,
              width: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [DunColors.DunColor, Colors.white],
                ),
              ),
            ),
            // 头部引用
            CookieHead(sourceData, isShowQR: true),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Cookies sourceData) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        children: [
          ExpandableText(
            sourceData.defaultCookie?.text ?? "",
            noExpandButton: true,
            expandLimit: 36,
            overflow: TextOverflow.ellipsis,
          ),
          sourceData.item?.retweeted != null
              ? Container(
                  decoration: const BoxDecoration(
                      color: gray_4,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableText(
                        "转发自：" +
                            (sourceData.item?.retweeted?.authorName ?? "") +
                            "\n" +
                            (sourceData.item?.retweeted?.text ?? ''),
                        noExpandButton: true,
                        expandLimit: 36,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: gray_2,
                          fontSize: 12,
                        ),
                      ),
                      CookieShareImage(data: sourceData, type: 2),
                    ],
                  ))
              : Container(),
        ],
      ),
      padding: const EdgeInsets.all(10),
    );
  }

//  顶部按钮
  _button(event, icon) {
    return IconButton(onPressed: () => event(), icon: Icon(icon));
  }

//  图片转流
  Future<Uint8List> _widgetToUint8List() async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // 让后续的代码异步执行，因为要先等UI变完再生成图片
    Completer<Uint8List> completer = Completer();
    RenderRepaintBoundary render =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image =
        await render.toImage(pixelRatio: ui.window.devicePixelRatio);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    completer.complete(byteData?.buffer.asUint8List());

    return completer.future;
  }

//图片保存
  void _widgetToImageSave() async {
    DunShareImageIsShare event = DunShareImageIsShare(true);
    eventBus.fire(event);
    Uint8List pngBytes = await _widgetToUint8List();
    final result = await ImageGallerySaver.saveImage(pngBytes,
        name:
            "ceobecanteen_" + DateTime.now().millisecondsSinceEpoch.toString());
    if (result["isSuccess"]) {
      DunToast.showSuccess("图片已保存");
    }
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.of(context).pop());
  }

//  图片分享
  void _widgetToImageShare() async {
    DunShareImageIsShare event = DunShareImageIsShare(true);
    eventBus.fire(event);
    Uint8List pngBytes = await _widgetToUint8List();
    final document = await getApplicationDocumentsDirectory();
    final dir = Directory(document.path +
        "/ceobecanteen_" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.png');
    final imageFile = File(dir.path);
    await imageFile.writeAsBytes(pngBytes);
    Share.shareFiles([imageFile.path]);
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.of(context).pop());
  }
}
