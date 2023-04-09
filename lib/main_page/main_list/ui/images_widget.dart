import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/view_image_main.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final SourceData? data;
  final SettingData? settingData;
  const ImageWidget({required this.data, required this.settingData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null || data?.hasImage != true) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.center,
      child: data?.isMultiImage == true ? _multiImage(context) : _oneImage(context),
      padding: const EdgeInsets.all(10),
    );
  }

  List<String> _checkIsPreview(isOneImage) {
    if (settingData?.isPreview == true && data?.previewList?.isNotEmpty == true) {
      // 如果有略缩图且开启了略缩图开关
      return data!.previewList!;
    }
    if (isOneImage) {
      return [data!.coverImage!];
    } else {
      return data!.imageList!;
    }
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
                    return FadeTransition(
                      opacity: anim1,
                      child: ViewImageExtendedImage(
                          text: data!.content!,
                          imageList: data!.isMultiImage ? data!.imageList : [data!.coverImage!],
                          currentIndex: index),
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: data!.isMultiImage ? data!.imageList![index] : data!.coverImage!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ExtendedRawImage(
                  height: 300,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  image: state.extendedImageInfo?.image,
                ),
              ),
            ),
          );
        }
        return null;
      },
    );
  }
}
