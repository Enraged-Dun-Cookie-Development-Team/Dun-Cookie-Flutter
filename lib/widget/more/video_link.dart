
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../model/ceobe/video/video.dart';
import '../image/dun_image.dart';

class VideoLinkCard extends StatelessWidget {
  final VideoModel linkInfo;
  final void Function(VideoModel videoModel)? onTap;

  const VideoLinkCard(this.linkInfo, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9.sp),
        boxShadow: const [
          BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 3),
              color: DunColors.cardShadow)
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DunImage.network(
                linkInfo.coverImg,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: REdgeInsets.all(8),
              child: Text(
                linkInfo.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: REdgeInsets.only(bottom: 3, right: 8),
                child: Text(
                  linkInfo.author,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            )
          ],
        ),
        onTap: () => onTap != null ? onTap!(linkInfo) : null,
      ),
    );
  }
}
