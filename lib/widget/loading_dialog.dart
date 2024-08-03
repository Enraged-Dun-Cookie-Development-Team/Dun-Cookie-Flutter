import 'package:dun_cookie_flutter/common/dun_color.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  const LoadingDialog({super.key});

  final dialogSize = 100.0, borderSize = 3.0, imgSize = 70.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: dialogSize / 3),
        height: dialogSize,
        width: dialogSize,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox.square(
                dimension: dialogSize - borderSize,
                child: CircularProgressIndicator(
                  color: DunColors.DunColor,
                  backgroundColor: DunColors.DunColor.withOpacity(0.4),
                  strokeWidth: borderSize,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: _buildImage(),
            ),
          ],
        ),
      ),
    );
  }

  Image _buildImage() {
    return Image.asset(
      "assets/image/load/loading.gif",
      height: imgSize,
      width: imgSize,
    );
  }
}
