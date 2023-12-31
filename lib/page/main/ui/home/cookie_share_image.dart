import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CookieShareImage extends StatefulWidget {
  CookieShareImage({Key? key, required this.data, int? type})
      : super(key: key) {
    _hasImage = (type == 1 &&
            data.defaultCookie?.images != null &&
            data.defaultCookie!.images!.isNotEmpty) ||
        (type == 2 &&
            data.item?.retweeted?.images!= null &&
            data.item!.retweeted!.images!.isNotEmpty);
    _imageList = [];
    if (_hasImage) {
      if(type == 1){
        for (var image in data.defaultCookie!.images!) {
          _imageList.add(image.originUrl!);
        }
      }else if(type ==2){
        for (var image in data.item!.retweeted!.images!) {
          _imageList.add(image.originUrl!);
        }
      }
    }
  }

  Cookies data;
  late final bool _hasImage;
  late List<String> _imageList;

  @override
  State<CookieShareImage> createState() => _CookieShareImageState();
}

class _CookieShareImageState extends State<CookieShareImage> {
  bool _showChecked = true;
  final Map<String, bool> _showImageList = {};

  @override
  void initState() {
    for (var element in widget._imageList) {
      _showImageList[element] = true;
    }
    eventBus.on<DunShareImageIsShare>().listen((event) {
      // Flutter中setState导致的内存泄漏——setState() Unhandled Exception: setState() called after dispose()
      if (mounted) {
        setState(() {
          _showChecked = !event.dunShareImageIsShare;
          widget._imageList = _handleImageList();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: !widget._hasImage
          ? Container()
          : widget._imageList.length > 1
              ? GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    widget._imageList.length,
                    (index) {
                      return GestureDetector(
                        child: Stack(
                          children: [
                            ExtendedImage.network(
                              widget._imageList[index],
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                            ),
                            Visibility(
                              visible: _showChecked,
                              child: Positioned(
                                child: _showImageList[widget._imageList[index]]
                                        as bool
                                    ? const Icon(
                                        Icons.check_box_outlined,
                                        size: 30,
                                        color: DunColors.DunColor,
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                top: 0,
                                right: 0,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _handleShowImage(widget._imageList[index]);
                        },
                      );
                    },
                  ),
                )
              : ExtendedImage.network(
                  widget._imageList[0],
                  width: double.infinity,
                ),
    );
  }

  _handleShowImage(image) {
    bool isShow = _showImageList[image] as bool;
    setState(() {
      _showImageList[image] = !isShow;
    });
  }

  List<String> _handleImageList() {
    List<String> list = [];
    _showImageList.forEach((key, value) {
      if (value) {
        list.add(key);
      }
    });
    return list;
  }
}
