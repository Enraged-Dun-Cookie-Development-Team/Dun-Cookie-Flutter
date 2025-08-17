import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../model/ceobe/tool/tool.dart';
import '../image/dun_image.dart';

class ToolLinkCard extends StatelessWidget {
  final ToolModel linkInfo;
  final void Function(ToolModel quickJump)? onTap;

  const ToolLinkCard(this.linkInfo, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: const [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 3),
                color: DunColors.cardShadow)
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.sp),
              child: DunImage.network(
                linkInfo.icon,
                width: 30.sp,
                height: 30.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                linkInfo.nameSet.localName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      onTap: () => onTap?.call(linkInfo),
    );
  }
}
