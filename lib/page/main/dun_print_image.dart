import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class DunPrintImage extends StatelessWidget {
   DunPrintImage({Key? key, required this.data})
      : hasImage = (data.coverImage != null || data.imageList!.isNotEmpty),
        isMultiImage =
            (data.coverImage != null || data.imageList!.isNotEmpty) &&
                data.imageList!.length > 1,
        super(key: key);

  SourceData data;
  final bool hasImage;
  final bool isMultiImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: !hasImage
          ? Container()
          : isMultiImage
              ? GridView(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    data.imageList!.length,
                    (index) {
                      return ExtendedImage.network(data.imageList![index],fit: BoxFit.cover,alignment: Alignment.topCenter,);
                    },
                  ),
                )
              : ExtendedImage.network(
                  data.coverImage!,
                  width: double.infinity,
                ),
    );
  }
}
