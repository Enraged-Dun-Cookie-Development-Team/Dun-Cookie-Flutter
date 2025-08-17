import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewImageExtendedImage extends StatefulWidget {
  const ViewImageExtendedImage({
    super.key,
    required this.imageList,
    this.initialIndex = 0,
  });

  //图片地址数组
  final List<String> imageList;

  //初始页数
  final int initialIndex;

  @override
  State<ViewImageExtendedImage> createState() => _ViewImageExtendedImageState();
}

class _ViewImageExtendedImageState extends State<ViewImageExtendedImage> {
  final RxInt _currentIndex = 0.obs;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex.value = widget.initialIndex;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  _buildImageView() {
    return PhotoViewGallery.builder(
      // 替代 PageView，内置分页逻辑
      pageController: _pageController,
      itemCount: widget.imageList.length,
      // 构建每个页面的图片
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(widget.imageList[index]),
          // 图片配置
          minScale: PhotoViewComputedScale.contained * 0.8, // 最小缩放
          maxScale: PhotoViewComputedScale.covered * 5.0, // 最大缩放
          initialScale: PhotoViewComputedScale.contained, // 初始缩放
        );
      },
      // 监听页码变化
      onPageChanged: (index) {
        setState(() {
          _currentIndex.value = index;
        });
      },
      // 滚动方向（水平/垂直）
      scrollDirection: Axis.horizontal,
    );
  }

  _buildImageInfo() {
    return Positioned(
      right: 0,
      child: Container(
        color: Colors.black26,
        padding: REdgeInsets.only(left: 10, right: 10),
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
