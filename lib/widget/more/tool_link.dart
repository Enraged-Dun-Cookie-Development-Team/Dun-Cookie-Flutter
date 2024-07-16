import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../model/ceobe/tool/tool.dart';

class ToolLinkCard extends StatelessWidget {
  ToolModel linkInfo;
  void Function(ToolModel quickJump)? onTap;

  ToolLinkCard(this.linkInfo, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    child: ExtendedImage.network(
                      linkInfo.avatar,
                      width: 30,
                      height: 30,
                    ),
                    borderRadius: BorderRadius.circular(4)),
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
