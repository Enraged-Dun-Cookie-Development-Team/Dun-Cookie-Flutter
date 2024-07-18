import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/ceobe/tool/tool.dart';

class ToolLinkCard extends StatelessWidget {
  ToolModel linkInfo;
  void Function(ToolModel quickJump)? onTap;

  ToolLinkCard(this.linkInfo, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.only(
          left: 10,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: ExtendedImage.network(
                      linkInfo.avatar,
                      width: 30,
                      height: 30,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  linkInfo.nickname,
                  maxLines: 1,
                ))
              ],
            ),
          ],
        ),
      ),
      onTap: () => onTap != null?onTap!(linkInfo):null,
    );
  }
}
