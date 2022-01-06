import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/provider/view_image_currentIndex_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewImageExtendedImage extends StatefulWidget {
  ViewImageExtendedImage({Key? key,
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

class _ViewImageExtendedImageState extends State<ViewImageExtendedImage> {
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
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black26,
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
