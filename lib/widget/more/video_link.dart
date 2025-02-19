import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';
import '../../model/ceobe/video/video.dart';

class VideoLinkCard extends StatelessWidget {
  final VideoModel linkInfo;
  final void Function(VideoModel videoModel)? onTap;

  const VideoLinkCard(this.linkInfo, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ExtendedImage.network(
                  linkInfo.coverImg,
                  fit: BoxFit.fill,
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.all(8.0),
              child: Text(
                linkInfo.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: DunStyles.text12,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: REdgeInsets.only(right: 8, bottom: 3),
              child: Text(
                linkInfo.author,
                maxLines: 1,
                style: DunStyles.text12,
              ),
            )
          ],
        ),
        onTap: () => onTap != null ? onTap!(linkInfo) : null,
      ),
    );
  }
}
