import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/provider/view_image_currentIndex_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewImageExtendedImage extends StatefulWidget {
  ViewImageExtendedImage({
    Key? key,
    required this.imageList,
    this.text = "",
    this.currentIndex = 0,
  }) : super(key: key);

//  图片地址数组
  List<String>? imageList;

//  当前看的第几章
  int currentIndex;

//  图片文字
  String text;

  @override
  _ViewImageExtendedImageState createState() => _ViewImageExtendedImageState();
}

class _ViewImageExtendedImageState extends State<ViewImageExtendedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ChangeNotifierProvider(
              create: (context) =>
                  ViewImageCurrentIndexProvider(widget.currentIndex),
              child: Consumer<ViewImageCurrentIndexProvider>(
                builder: (ctx, data, child) {
                  return Stack(
                    children: [_imageView(data), _bottomInfo(data)],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _imageView(data) {
    return ExtendedImageGesturePageView.builder(
      itemBuilder: (BuildContext context, int index) {
        var item = widget.imageList![index];
        Widget image = ExtendedImage.network(
          item,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          onDoubleTap: (state) {
            double? begin = 0.0;
            double end = 0.0;
            if (state.gestureDetails?.totalScale == 1.0) {
              begin = 1.0;
              end = 2.0;
            } else {
              begin = state.gestureDetails?.totalScale;
              end = 1.0;
            }
            try {
              _animationController.reset();
              _animation = Tween<double>(begin: begin, end: end)
                  .animate(_animationController);
              _animation.addListener(() {
                state.handleDoubleTap(
                    scale: _animation.value,
                    doubleTapPosition: state.pointerDownPosition);
              });
              _animationController.forward();
            } catch (e) {
              print('放大错误');
            }
          },
        );
        image = Container(
          child: image,
          padding: const EdgeInsets.all(5.0),
        );
        return Hero(
          tag: item,
          child: image,
        );
      },
      itemCount: widget.imageList!.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        data.setCurrentIndex(index);
      },
      controller: ExtendedPageController(initialPage: widget.currentIndex),
    );
  }

  _bottomInfo(data) {
    return Positioned(
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black26,
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: _imageInfoText(widget.text),
            ),
            const SizedBox(
              width: 10,
            ),
            _imageInfoText(
                "${data.currentIndex + 1}/${widget.imageList!.length}")
          ],
        ),
      ),
    );
  }

  Text _imageInfoText(text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(color: Colors.white),
    );
  }
}
