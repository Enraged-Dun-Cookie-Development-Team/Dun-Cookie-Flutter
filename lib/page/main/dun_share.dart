import 'dart:io';
import 'dart:typed_data';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_content.dart';
import 'package:dun_cookie_flutter/page/main/dun_headren.dart';
import 'package:dun_cookie_flutter/page/main/dun_share_image.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:widget_to_image/widget_to_image.dart';

class DunWidgetToImage extends StatefulWidget {
  DunWidgetToImage({Key? key}) : super(key: key);
  static String routeName = "/widgetToImage";

  @override
  State<DunWidgetToImage> createState() => _DunWidgetToImageState();
}

class _DunWidgetToImageState extends State<DunWidgetToImage> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SourceData sourceData =
        ModalRoute.of(context)!.settings.arguments as SourceData;
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
                          // 卡片中部
                          DunContent(sourceData),
                          // 卡片图片
                          DunShareImage(data: sourceData),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "-去应用商店下载小刻食堂-",
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

  _stackHear(sourceData) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 二维码
        Positioned(
          right: 5,
          top: 5,
          child: SizedBox(
            height: 120,
            child: QrImage(
                data: sourceData.jumpUrl!,
                version: QrVersions.auto,
                gapless: false,
                foregroundColor: DunColors.DunColor),
          ),
        ),
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
            DunHead(sourceData, isShowQR: true),
          ],
        ),
      ],
    );
  }

//  顶部按钮
  _button(event, icon) {
    return IconButton(onPressed: () => event(), icon: Icon(icon));
  }

//  图片转流
  _widgetToUint8List() async {
    ByteData byteData =
        await WidgetToImage.repaintBoundaryToImage(_globalKey, pixelRatio: 2.0);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
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
  }
}
