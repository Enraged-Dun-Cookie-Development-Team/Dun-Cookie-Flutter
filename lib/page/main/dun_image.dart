import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:flutter/material.dart';

class CardImage extends StatefulWidget {
  CardImage(this.info, {Key? key}) : super(key: key);

  SourceData info;

  @override
  _CardImageState createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
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
  ClipRRect _oneImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
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
  FadeInImage _kazeFadeImage(netSrc) {
    return FadeInImage(
      height: 200,
      fit: BoxFit.cover,
      placeholder: const AssetImage("assets/logo/logo.png"),
      image: NetworkImage(netSrc),
    );
  }
}
