import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ViewImageExtendedImage extends StatefulWidget {
  ViewImageExtendedImage(
    this.imageList, {
    Key? key,
  }) : super(key: key);

  List<String> imageList;

  @override
  _ViewImageExtendedImageState createState() => _ViewImageExtendedImageState();
}

class _ViewImageExtendedImageState extends State<ViewImageExtendedImage> {
  @override
  Widget build(BuildContext context) {
    return ExtendedImageGesturePageView.builder(
      itemBuilder: (BuildContext context, int index) {
        var item = widget.imageList[index];
        Widget image = ExtendedImage.network(
          item,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
        );
        return image;
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
