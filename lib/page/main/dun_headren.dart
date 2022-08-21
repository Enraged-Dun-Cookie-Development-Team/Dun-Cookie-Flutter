import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/page/main/dun_share.dart';
import 'package:flutter/material.dart';

class DunHead extends StatelessWidget {
  DunHead(this.info, {Key? key, this.isShowQR = false})
      : source = info.sourceInfo!,
        super(key: key);

  SourceData info;
  SourceInfo source;
  final bool isShowQR;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  source.icon,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    source.title,
                    style: DunStyles.text16,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    info.timeForDisplay!,
                    style: DunStyles.text14B,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              isShowQR
                  ? Container()
                  : IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        Navigator.pushNamed(context, DunWidgetToImage.routeName,
                            arguments: info);
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }
}
