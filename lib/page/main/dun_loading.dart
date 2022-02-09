import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DunLoading extends StatelessWidget {
  const DunLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (ctx, mode) {
        String imageLink = "assets/image/load/load.png";
        String text = "状态展示";
        if (mode == RefreshStatus.idle) {
          imageLink = "assets/image/load/load.png";
          text = "下拉";
        } else if (mode == RefreshStatus.refreshing) {
          imageLink = "assets/image/load/loading.gif";
          text = "刷新中";
        } else if (mode == RefreshStatus.canRefresh) {
          imageLink = "assets/image/load/load.png";
          text = "松开刷新";
        } else if (mode == RefreshStatus.completed) {
          imageLink = "assets/image/load/load.png";
          text = "刷新完成";
        }
        return Center(
          child: Row(
            children: [
              Image.asset(
                imageLink,
                height: 50,
              ),
              Text("状态:" + text)
            ],
          ),
        );
      },
    );
  }
}
