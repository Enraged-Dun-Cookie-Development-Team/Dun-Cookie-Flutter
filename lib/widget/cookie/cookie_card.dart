import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../dashed_line_widget.dart';
import 'cookie_content.dart';
import 'cookie_title.dart';

class CookieCard extends StatelessWidget {
  final Cookie data;
  final Function(Cookie cookie) onTapCard;
  final Function(Cookie cookie) onTapShare;
  final Function(List<String> imageURLList, int currentIndex)? onTapImage;

  const CookieCard(
      {super.key,
      required this.data,
      required this.onTapCard,
      required this.onTapShare,
      this.onTapImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapCard(data);
      },
      //onTapCard(context, data.source!.type, data.item!.id, data.item!.url),
      child: Container(
        margin: REdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTop(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 左上灰色label
        Container(
          margin: REdgeInsets.only(bottom: 1, right: 10),
          width: 15,
          height: 60,
          color: DunColors.gray_1,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTitle(),
                  Padding(
                    padding: REdgeInsets.only(right: 5),
                    child: _buildShareIcon(context),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: DashedLineHorizontalWidget(),
                    ),
                  ),

                  /// 右上黄色label
                  Padding(
                    padding: REdgeInsets.only(right: 15),
                    child: Container(
                      width: 13,
                      height: 19,
                      color: DunColors.yellow,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: REdgeInsets.only(top: 6),
      child: CookieTitle(
        cookie: data,
        titleStyle: const TextStyle(
          fontSize: 15,
          color: DunColors.yellow,
        ),
        timeStyle: const TextStyle(
          fontSize: 14,
          color: DunColors.gray_2,
        ),
      ),
    );
  }

  Widget _buildShareIcon(BuildContext context) {
    return IconButton(
      iconSize: 18,
      icon: const Icon(Icons.share),
      color: Colors.black,
      onPressed: () {
        //跳转至分享页面
        onTapShare(data);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20),
      child: CookieContent(
        cookie: data,
        onTapImage: onTapImage,
      ),
    );
  }
}
