import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/common/tool/view_image_main.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class DunImage extends StatefulWidget {
  DunImage(this.info, {Key? key})
      : hasImage = info.coverImage != null || info.imageList!.isNotEmpty,
        isMultiImage =
            (info.coverImage != null || info.imageList!.isNotEmpty) &&
                info.imageList!.length > 1,
        super(key: key);

  SourceData info;
  bool hasImage = false;
  bool isMultiImage = false;

  @override
  _DunImageState createState() => _DunImageState();
}

class _DunImageState extends State<DunImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation _opacity;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_animation);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasImage) {
      return Container(
        alignment: Alignment.center,
        child: widget.isMultiImage ? _multiImage() : _oneImage(),
        padding: const EdgeInsets.all(10),
      );
    } else {
      return Container();
    }
  }

  /// 一张图
  _oneImage() {
    return _kazeFadeImage(
      widget.info.coverImage!,
    );
  }

  /// 多张图
  _multiImage() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        widget.info.imageList!.length,
        (index) {
          return _kazeFadeImage(
            widget.info.imageList![index],
            index: index,
          );
        },
      ),
    );
  }

  ///
  /// 图片渐变
  /// index 当前图片如果是多图的话 就是被那个图片的index 如果是单图 就是0
  ///
  _kazeFadeImage(netSrc, {index = 0}) {
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
          final progress = _expectedTotalBytes != 0
              ? _cumulativeBytesLoaded / _expectedTotalBytes
              : null;
          return Stack(
            alignment: Alignment.center,
            children: [
              const Image(image: AssetImage("assets/logo/logo.png")),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
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
                          text: widget.info.content!,
                          imageList: widget.isMultiImage
                              ? widget.info.imageList
                              : [widget.info.coverImage!],
                          currentIndex: index),
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: widget.isMultiImage
                  ? widget.info.imageList![index]
                  : widget.info.coverImage!,
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
