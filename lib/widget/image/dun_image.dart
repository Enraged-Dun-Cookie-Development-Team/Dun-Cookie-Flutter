import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DunImage {
  static Widget network(
    String url, {
    BoxFit fit = BoxFit.contain,
    double? height,
    double? width,
    Map<String, String> headers = const {},
    LoadingBuilder? loadingBuilder,
    PhotoViewImageTapUpCallback? onTapUp,
  }) =>
      SizedBox(
        height: height,
        width: width,
        child: PhotoView(
          imageProvider: NetworkImage(url, headers: headers),
          // 加载状态处理（对应原loadStateChanged）
          loadingBuilder: loadingBuilder ??
                  (context, event) {
                // 加载中显示GIF占位图
                return Image(
                  height: height,
                  width: width,
                  fit: fit,
                  image: const AssetImage("assets/image/load/loading.gif"),
                );
              },
          // 错误处理
          errorBuilder: (context, error, stackTrace) {
            return Image(
              height: height,
              width: width,
              fit: fit,
              image: const AssetImage("assets/image/load/error.png"),
            );
          },
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          wantKeepAlive: true,
          onTapUp: onTapUp,
        ),
      );
}
