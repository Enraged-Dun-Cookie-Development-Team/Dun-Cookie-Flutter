import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/view_image_main.dart';
import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final List<CookieImage>? data;
  final String? sourceType;
  final SettingData? settingData;
  const ImageWidget({required this.data, required this.sourceType, required this.settingData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.center,
      child: data!.length > 1 ? _multiImage(context) : _oneImage(context),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    );
  }

  List<String> _checkIsPreview(isOneImage) {
    if (settingData?.isPreview == true && data?.isNotEmpty == true) {
      List<String> previewList = _getPreviewList(data!, sourceType!);
      return previewList;
    }
    else {
      List<String> originList = [];
      // 如果有略缩图且开启了略缩图开关
      for (var img in data!) {
        originList.add(img.originUrl!);
      }
      return originList;
    }
  }

  /// 适配各端获取预览图
  List<String> _getPreviewList(List<CookieImage> data, String sourceType) {
    List<String> previewList = [];
    for (var img in data) {
      if (img.compressUrl != null) {
        previewList.add(img.compressUrl!);
      } else if (sourceType == "bilibili:dynamic-by-uid") {
        if (data.length == 1) {
          previewList.add(img.originUrl!+"@573w_358h_1e_1c_!web-dynamic.webp");
        } else {
          previewList.add(img.originUrl!+"@416w_416h_1e_1c_!web-dynamic.webp");
        }
      } else if (sourceType == "netease-cloud-music:albums-by-artist") {
        previewList.add(img.originUrl!+"?param=416x416");
      } else {
        previewList.add(img.originUrl!);
      }
    }
    return previewList;
  }

  /// 一张图
  _oneImage(BuildContext context) {
    var imageList = _checkIsPreview(true);
    return _kazeFadeImage(context, imageList[0]);
  }

  /// 多张图
  _multiImage(BuildContext context) {
    var imageList = _checkIsPreview(false);
    return GridView(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(imageList.length, (index) {
        return _kazeFadeImage(
          context,
          imageList[index],
          index: index,
        );
      }),
    );
  }

  ///
  /// 图片渐变
  /// index 当前图片如果是多图的话 就是被那个图片的index 如果是单图 就是0
  ///
  _kazeFadeImage(BuildContext context, String netSrc, {index = 0}) {
    var _cumulativeBytesLoaded = 0;
    var _expectedTotalBytes = 0;
    return ExtendedImage.network(
      netSrc,
      fit: BoxFit.cover,
      handleLoadingProgress: true,
      clearMemoryCacheIfFailed: true,
      clearMemoryCacheWhenDispose: false,
      mode: ExtendedImageMode.gesture,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        if (state.extendedImageLoadState == LoadState.loading) {
          final loadingProgress = state.loadingProgress;
          _cumulativeBytesLoaded = loadingProgress?.cumulativeBytesLoaded ?? 0;
          _expectedTotalBytes = loadingProgress?.expectedTotalBytes ?? 0;
          final progress =
              _expectedTotalBytes != 0 ? _cumulativeBytesLoaded / _expectedTotalBytes : null;
          return Stack(
            alignment: Alignment.center,
            children: [
              const Image(image: AssetImage("assets/image/load/loading.gif")),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.white,
                  child: Text(
                    "${((progress ?? 0.0) * 100).toInt()}%",
                    style: DunStyles.text14C,
                  ),
                ),
              )
            ],
          );
        } else if (state.extendedImageLoadState == LoadState.completed) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (ctx, anim1, anim2) {
                    List<String> imgList = [];
                    for (var img in data!) {
                      imgList.add(img.originUrl!);
                    }
                    return FadeTransition(
                      opacity: anim1,
                      child: ViewImageExtendedImage(
                          text: "",
                          imageList: imgList,
                          currentIndex: index),
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: data![index].originUrl!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: ExtendedRawImage(
                    // height: 300,
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: state.extendedImageInfo?.image,
                  ),
                )

              ),
            ),
          );
        }
        return null;
      },
    );
  }
}
