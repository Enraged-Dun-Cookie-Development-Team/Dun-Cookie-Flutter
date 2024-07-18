import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../../common/dun_toast.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../widget/cookie/cookie_content.dart';
import 'state.dart';

class CookieShareLogic extends GetxController {
  final CookieShareState state = CookieShareState();

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments is Cookie) {
      state.cookie = arguments;
      state.selectedImage.addAll(state.cookie.defaultCookie.images);
      state.selectedRetweetedImage
          .addAll(state.cookie.item.retweeted?.images ?? []);
      update([state.rootGID]);
    }
  }

  void onTapBack() {
    Get.back();
  }

  Future<void> onTapSave() async {
    state.type.value = CookieContentType.image;
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      Uint8List? pngBytes = await _generateImageData();
      if (pngBytes != null) {
        final result = await ImageGallerySaver.saveImage(pngBytes,
            name: "ceobecanteen_${DateTime.now().millisecondsSinceEpoch}");
        if (result["isSuccess"]) {
          DunToast.showSuccess("图片已保存");
        }
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        DunToast.showError('图片生成失败');
      }
    } catch (e) {
      DunToast.showError('图片保存失败,${e.toString()}');
    }
  }

  Future<void> onTapShare() async {
    state.type.value = CookieContentType.image;
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      Uint8List? pngBytes = await _generateImageData();
      if (pngBytes != null) {
        final document = await getApplicationDocumentsDirectory();
        final dir = Directory(
            "${document.path}/ceobecanteen_${DateTime.now().millisecondsSinceEpoch.toString()}.png");
        final imageFile = File(dir.path);
        await imageFile.writeAsBytes(pngBytes);
        Share.shareFiles([imageFile.path]);
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        DunToast.showError('图片生成失败');
      }
    } catch (e) {
      DunToast.showError('图片分享失败,${e.toString()}');
    }
  }

  Future<Uint8List?> _generateImageData() async {
    //根据Globalkey获取RenderObject对象
    final boundary = state.boundaryKey.currentContext?.findRenderObject();
    if (boundary != null && boundary is RenderRepaintBoundary) {
      double dpr = window.devicePixelRatio;
      final image = await boundary.toImage(pixelRatio: dpr);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        Uint8List imageData = byteData.buffer.asUint8List();
        return imageData;
      }
    }
    DunToast.showError('图片生成失败');
    return null;
  }

  onSelectImage(CookieImage cookieImage, bool value, bool isRetweeted) {
    if (value) {
      isRetweeted
          ? state.selectedRetweetedImage.add(cookieImage)
          : state.selectedImage.add(cookieImage);
    } else {
      isRetweeted
          ? state.selectedRetweetedImage.remove(cookieImage)
          : state.selectedImage.remove(cookieImage);
    }
  }
}
