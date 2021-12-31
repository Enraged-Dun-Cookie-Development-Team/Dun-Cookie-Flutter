import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CardImage extends StatefulWidget {
  CardImage(this.info, {Key? key}) : super(key: key);

  SourceData info;

  @override
  _CardImageState createState() => _CardImageState();
}

class _CardImageState extends State<CardImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation _opacity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_animation);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.info.coverImage != null || widget.info.imageList!.isNotEmpty) {
      return Container(
        child: widget.info.imageList!.length > 1 ? _multiImage() : _oneImage(),
        padding: const EdgeInsets.all(10),
      );
    } else {
      return Container();
    }
  }

  /// 一张图
  Container _oneImage() {
    return Container(
      alignment: Alignment.topLeft,
      child: _kazeFadeImage(widget.info.coverImage!),
    );
  }

  /// 多张图
  GridView _multiImage() {
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
        (index) => _kazeFadeImage(widget.info.imageList![index]),
      ),
    );
  }

  /// 图片渐变
  ClipRRect _kazeFadeImage(netSrc) {
    var _cumulativeBytesLoaded = 0;
    var _expectedTotalBytes = 0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: ExtendedImage.network(
        netSrc,
        fit:BoxFit.cover,
        handleLoadingProgress: true,
        clearMemoryCacheIfFailed: true,
        clearMemoryCacheWhenDispose: true,
        mode: ExtendedImageMode.gesture,
        cache: true,
        loadStateChanged: (ExtendedImageState state) {
          if (state.extendedImageLoadState == LoadState.loading) {
            final loadingProgress = state.loadingProgress;
            _cumulativeBytesLoaded =
                loadingProgress?.cumulativeBytesLoaded ?? 0;
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Text(
                      "${((progress ?? 0.0) * 100).toInt()}%",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 35, 173, 229),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          // else if (state.extendedImageLoadState == LoadState.completed) {
          //   return Text("加载完成");
          // }
          return null;
        },
      ),
    );
  }
}
