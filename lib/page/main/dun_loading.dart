import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DunLoading extends StatelessWidget {
  const DunLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (ctx, mode) {
        String imageLink = "assets/image/load/load.png";
        if (mode == RefreshStatus.idle) {
          imageLink = "assets/image/load/load.png";
        } else if (mode == RefreshStatus.refreshing) {
          imageLink = "assets/image/load/loading.gif";
        } else if (mode == RefreshStatus.canRefresh) {
          imageLink = "assets/image/load/load.png";
        } else if (mode == RefreshStatus.completed) {
          imageLink = "assets/image/load/success.png";
        }
        return Center(
          child: Image.asset(
            imageLink,
            height: 60,
          ),
        );
      },
    );
  }
}
