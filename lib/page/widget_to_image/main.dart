import 'dart:typed_data';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:widget_to_image/widget_to_image.dart';

class DunWidgetToImage extends StatelessWidget {
  DunWidgetToImage({Key? key, required info}) : super(key: key);
  final GlobalKey _globalKey = GlobalKey();

  late SourceData info;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(
          key: _globalKey,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [

                ],)
                // QrImage(
                //   data: '一起助力蹲饼！',
                //   version: QrVersions.auto,
                //   gapless: false,
                //   embeddedImage: AssetImage('assets/logo/logo.png'),
                //   embeddedImageStyle: QrEmbeddedImageStyle(
                //     size: Size(80, 80),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _callRepaintBoundaryToImage() async {
    ByteData byteData =
        await WidgetToImage.repaintBoundaryToImage(this._globalKey);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    final result = await ImageGallerySaver.saveImage(pngBytes,
        quality: 100, name: "hello");
    print(result);
  }
}
