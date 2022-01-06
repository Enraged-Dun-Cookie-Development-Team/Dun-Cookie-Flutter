import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_content.dart';
import 'package:dun_cookie_flutter/page/main/dun_headren.dart';
import 'package:dun_cookie_flutter/page/main/dun_print_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SourceData sourceData =
        ModalRoute.of(context)!.settings.arguments as SourceData;
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("小刻名片生成"), actions: [
          _button(_widgetToImageSave, Icons.save_alt),
          _button(_widgetToImageShare, Icons.share)
        ]),
        body: ListView(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                color: Colors.white,
                width: size.width,
                padding: EdgeInsets.all(20),
                child: Card(
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
                      DunPrintImage(data: sourceData)
                    ],
                  ),
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
            ),
          ),
        ),
        // 小刻食堂标题和下面的分界线
        Positioned(
          left: 0,
          top: 60,
          child: Container(
            height: 3,
            width: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 35, 173, 229), Colors.white],
              ),
            ),
          ),
        ),
        // 小刻食堂标题
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/logo/logo.png",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "小刻食堂",
                    style: TextStyle(
                        fontSize: 28, color: Color.fromARGB(255, 35, 173, 229)),
                  )
                ],
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
    Uint8List pngBytes = await _widgetToUint8List();
    final result = await ImageGallerySaver.saveImage(pngBytes,
        name: DateTime.now().toString());
    print(result);
    if (result["isSuccess"]) {
      Fluttertoast.showToast(msg: "保存完成", fontSize: 16.0);
    }
  }

//  图片分享
  void _widgetToImageShare() async {
    Uint8List pngBytes = await _widgetToUint8List();
    final document = await getApplicationDocumentsDirectory();
    final dir = Directory(document.path +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.png');
    final imageFile = File(dir.path);
    await imageFile.writeAsBytes(pngBytes);
    Share.shareFiles([imageFile.path]);
  }
}
