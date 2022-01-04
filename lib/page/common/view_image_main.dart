import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/view_image_Model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewImageExtendedImage extends StatefulWidget {
  ViewImageExtendedImage({
    Key? key,
    required this.isMultiImage,
    required this.info,
    this.currentIndex = 0,
  }) : imageList = isMultiImage ? info.imageList : [info.coverImage!];

  List<String>? imageList;
  int currentIndex;
  bool isMultiImage = false;
  SourceData info;

  @override
  _ViewImageExtendedImageState createState() => _ViewImageExtendedImageState();
}

class _ViewImageExtendedImageState extends State<ViewImageExtendedImage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: ChangeNotifierProvider(
            create: (context) => ViewImageModel(),
            child: Consumer<ViewImageModel>(
              // TODO Provider初始化有问题 问问人
              builder: (ctx, data, child) {
                return Stack(
                  children: [
                    ExtendedImageGesturePageView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        var item = widget.imageList![index];
                        Widget image = ExtendedImage.network(
                          item,
                          fit: BoxFit.contain,
                          mode: ExtendedImageMode.gesture,
                        );
                        image = Container(
                          child: image,
                          padding: EdgeInsets.all(5.0),
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
                      controller: ExtendedPageController(
                          initialPage: widget.currentIndex),
                    ),
                    Positioned(
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
                              child: _imageInfoText("${widget.info.content}"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _imageInfoText(
                                "${data.currentIndex + 1}/${widget.imageList!.length}")
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Text _imageInfoText(text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(color: Colors.white),
    );
  }
}

class providerExtendedImageGesturePageView extends StatelessWidget {
  const providerExtendedImageGesturePageView({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ViewImageExtendedImage widget;

  @override
  Widget build(BuildContext context) {
    final viewImageModel = Provider.of<ViewImageModel>(context);
    // viewImageModel.setCurrentIndex(widget.currentIndex);
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
          padding: EdgeInsets.all(5.0),
        );
        return Hero(
          tag: item,
          child: image,
        );
      },
      itemCount: widget.imageList!.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        viewImageModel.setCurrentIndex(index);
      },
      controller: ExtendedPageController(initialPage: widget.currentIndex),
    );
  }
}
