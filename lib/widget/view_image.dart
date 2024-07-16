import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../common/dun_toast.dart';

class ViewImageExtendedImage extends StatefulWidget {
  const ViewImageExtendedImage({
    Key? key,
    required this.imageList,
    this.initialIndex = 0,
  }) : super(key: key);

  //图片地址数组
  final List<String> imageList;

  //初始页数
  final int initialIndex;

  @override
  _ViewImageExtendedImageState createState() => _ViewImageExtendedImageState();
}

class _ViewImageExtendedImageState extends State<ViewImageExtendedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ExtendedPageController _extendedPageController;
  final RxInt _currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _extendedPageController =
        ExtendedPageController(initialPage: widget.initialIndex);
    _currentIndex.value = widget.initialIndex;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _extendedPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "小刻食堂",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Stack(
              children: [_buildImageView(), _buildImageInfo()],
            ),
          ),
        ),
      ),
    );
  }

  _buildImageView() {
    return ExtendedImageGesturePageView.builder(
      itemBuilder: (BuildContext context, int index) {
        var item = widget.imageList[index];
        return GestureDetector(
          onLongPress: () async {
            Uint8List? bytes = await getNetworkImageData(item, useCache: true);
            final result = await ImageGallerySaver.saveImage(bytes!,
                name: DateTime.now().toString());
            if (result["isSuccess"]) {
              DunToast.showSuccess("保存完成");
            }
          },
          child: Container(
            child: ExtendedImage.network(
              item,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  inPageView: true,
                );
              },
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
            ),
            padding: const EdgeInsets.all(5.0),
          ),
        );
      },
      itemCount: widget.imageList.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        _currentIndex.value = index;
      },
      controller: _extendedPageController,
    );
  }

  _buildImageInfo() {
    return Positioned(
      right: 0,
      child: Container(
        color: Colors.black26,
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => _indexInfo(
                  "${_currentIndex.value + 1}/${widget.imageList.length}"),
            )
          ],
        ),
      ),
    );
  }

  Text _indexInfo(text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(color: Colors.white),
    );
  }
}
