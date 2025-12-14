import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class DunImage {
  static Widget network(
    String url, {
    BoxFit fit = BoxFit.contain,
    double? height,
    double? width,
    BoxConstraints? constraints,
    Map<String, String> headers = const {},
    Widget Function(ImageChunkEvent? event)? loadingBuilder,
    GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ExtendedImage.network(
        url,
        handleLoadingProgress: true,
        clearMemoryCacheIfFailed: true,
        clearMemoryCacheWhenDispose: false,
        mode: ExtendedImageMode.gesture,
        cache: true,
        headers: headers,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              if (loadingBuilder != null) {
                return loadingBuilder(state.loadingProgress);
              }
              return Image(
                height: height,
                width: width,
                fit: fit,
                image: const AssetImage("assets/image/load/loading.gif"),
              );
            case LoadState.completed:
              return Container(
                clipBehavior: Clip.hardEdge,
                constraints: constraints,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: ExtendedRawImage(
                  height: height,
                  width: width,
                  fit: fit,
                  alignment: Alignment.topCenter,
                  image: state.extendedImageInfo?.image,
                ),
              );
            case LoadState.failed:
              return Image(
                height: height,
                width: width,
                fit: fit,
                image: const AssetImage("assets/image/load/error.png"),
              );
          }
        },
      ),
    );
  }
}
