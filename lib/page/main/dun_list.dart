import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/page/common/view_image_main.dart';
import 'package:dun_cookie_flutter/page/main/dun_image.dart';
import 'package:dun_cookie_flutter/service/main_request.dart';
import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<SourceData> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainRequest.canteenCardListAll().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, index) {
            var info = list[index];
            return Container(
              child: Column(
                children: [
                  _kazeTitle(info),
                  _kazeContent(info),
                  CardImage(info),
                  Container(
                    width: double.infinity,
                    height: 6,
                    color: Color.fromARGB(25, 0, 0, 0),
                  )
                ],
              ),
            );
          },
        ),
        const TestText()
      ],
    );
  }

  /**
   * 头部
   */
  Container _kazeTitle(SourceData info) {
    SourceInfo source = info.sourceInfo;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              source.icon!,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                source.title!,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                info.timeForDisplay,
                style: const TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _kazeContent(SourceData info) {
    return Container(
      width: double.infinity,
      child: Text(info.content.toString()),
      padding: EdgeInsets.all(10),
    );
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
