import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_card_item.dart';
import 'package:dun_cookie_flutter/service/main_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class DunList extends StatefulWidget {
  const DunList({Key? key}) : super(key: key);
  static String routeName = "/dunList";

  @override
  State<DunList> createState() => _DunListState();
}

class _DunListState extends State<DunList> {
  @override
  void initState() {
    super.initState();
    // 清除30天前的图片缓存
    clearDiskCachedImages(duration: const Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<SourceData>>(
          future: MainRequest.canteenCardListAll(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data != null) {
              final list = snapshot.data!;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, index) {
                  var info = list[index];
                  return DunCardItem(
                    info: info,
                    index: index,
                  );
                },
              );
            }
            return const Center(
              child: Text("报错了"),
            );
          },
        ),
        const TestText()
      ],
    );
  }

  //  获取数据
  // _getDate() {
  //   MainRequest.canteenCardListAll().then((value) {
  //     setState(() {
  //       list = value;
  //     });
  //     return true;
  //   });
  // }

  // 下拉刷新
  Future<void> _onRefresh() async {
    // 持续两秒 先不需要等待
    // await _getDate();
    // await Future.delayed(Duration(milliseconds: 2000), () {});
  }
}

class TestText extends StatelessWidget {
  const TestText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 10,
      right: 10,
      child: Text(
        "本界面内容仅供展示，具体请以程序实际情况为准。",
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
          shadows: [
            Shadow(
              color: Colors.black38,
              blurRadius: 10,
            )
          ],
        ),
      ),
    );
  }
}
