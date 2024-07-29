import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../manager/settingManager.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../check_widget.dart';

class ImageWidget extends StatelessWidget {
  final List<CookieImage> cookieImageList;
  final String sourceType;
  final bool showCheck;
  final bool imageFill;
  final Function(List<String> imageURLList, int currentIndex)? onTap;
  final Function(CookieImage cookieImage, bool value)? onSelect;

  const ImageWidget({
    super.key,
    required this.cookieImageList,
    required this.sourceType,
    this.onTap,
    this.onSelect,
    this.showCheck = false,
    required this.imageFill,
  });

  @override
  Widget build(BuildContext context) {
    if (cookieImageList.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      alignment: Alignment.center,
      child: cookieImageList.length > 1
          ? _multiImage(context)
          : _oneImage(context),
      padding: REdgeInsets.fromLTRB(0, 10, 0, 0),
    );
  }

  List<String> _checkIsPreview(isOneImage) {
    if (SettingManager.getInstance().isPreview) {
      List<String> previewList = _getPreviewList(cookieImageList, sourceType);
      return previewList;
    } else {
      List<String> originList = [];
      for (var img in cookieImageList) {
        originList.add(img.originUrl);
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
          previewList.add("${img.originUrl}@573w_358h_1e_1c_!web-dynamic.webp");
        } else {
          previewList.add("${img.originUrl}@416w_416h_1e_1c_!web-dynamic.webp");
        }
      } else if (sourceType == "netease-cloud-music:albums-by-artist") {
        previewList.add("${img.originUrl}?param=416x416");
      } else {
        previewList.add(img.originUrl);
      }
    }
    return previewList;
  }

  /// 一张图
  _oneImage(BuildContext context) {
    var imageURLList = _checkIsPreview(true);
    return _kazeFadeImage(
      url: imageURLList[0],
      isSingle: true,
      onTap: () {
        if (onTap != null) {
          onTap!(imageURLList, 0);
        }
      },
      onSelect: (bool value) {
        if (onSelect != null) {
          onSelect!(cookieImageList[0], value);
        }
      },
    );
  }

  /// 多张图
  _multiImage(BuildContext context) {
    var imageURLList = _checkIsPreview(false);
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
      children: List.generate(imageURLList.length, (index) {
        return _kazeFadeImage(
          url: imageURLList[index],
          isSingle: false,
          onTap: () {
            if (onTap != null) {
              onTap!(imageURLList, index);
            }
          },
          onSelect: (bool value) {
            if (onSelect != null) {
              onSelect!(cookieImageList[index], value);
            }
          },
        );
      }),
    );
  }

  ///
  /// 图片渐变
  /// index 当前图片如果是多图的话 就是被那个图片的index 如果是单图 就是0
  /// 注意在network_image_io文件下的Future<HttpClientResponse> _getResponse(Uri resolved)函数开头添加 httpClient.userAgent = null;
  ///
  _kazeFadeImage(
      {required String url,
      required bool isSingle,
      required void Function() onTap,
      required void Function(bool value) onSelect}) {
    return Stack(
      children: [
        ExtendedImage.network(
          url,
          fit: BoxFit.cover,
          handleLoadingProgress: true,
          clearMemoryCacheIfFailed: true,
          clearMemoryCacheWhenDispose: false,
          mode: ExtendedImageMode.gesture,
          cache: true,
          headers: {
            HttpHeaders.userAgentHeader: FkUserAgent.userAgent!,
          },
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                final loadingProgress = state.loadingProgress;
                int cumulativeBytesLoaded =
                    loadingProgress?.cumulativeBytesLoaded ?? 0;
                int expectedTotalBytes =
                    loadingProgress?.expectedTotalBytes ?? 0;
                double progress = expectedTotalBytes != 0
                    ? cumulativeBytesLoaded / expectedTotalBytes
                    : 0.0;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(isSingle ? 60 : 10),
                      child: const Image(
                          image: AssetImage("assets/image/load/loading.gif")),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: REdgeInsets.all(4),
                        color: Colors.white,
                        child: Text(
                          "${((progress) * 100).toInt()}%",
                          style: DunStyles.text14C,
                        ),
                      ),
                    )
                  ],
                );
              case LoadState.completed:
                return GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        constraints: BoxConstraints(
                            maxHeight: imageFill ? double.infinity : 400),
                        child: ExtendedRawImage(
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          image: state.extendedImageInfo?.image,
                        ),
                      )),
                );
              case LoadState.failed:
                print('图片加载失败:$url');
                return const Image(
                    image: AssetImage("assets/image/load/error.png"));
            }
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Visibility(
            visible: showCheck,
            child: CheckWidget(
              initialValue: true,
              callBack: onSelect,
            ),
          ),
        )
      ],
    );
  }
}
