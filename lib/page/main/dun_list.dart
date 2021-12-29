import 'package:dun_cookie_flutter/model/source_data_entity.dart';
import 'package:dun_cookie_flutter/service/main_request.dart';
import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<SourceDataEntity> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      MainRequest.canteenCardListAll().then((value) {
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
                  _kazeImage(info),
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
  Container _kazeTitle(info) {
    var source = info.sourceInfo;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              source.icon,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                source.title,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                info.timeForDisplay,
                style: TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _kazeContent(info) {
    return Container(
      width: double.infinity,
      child: Text(info.content.toString()),
      padding: EdgeInsets.all(10),
    );
  }

  Container _kazeImage(info) {
    return Container(
      child: info.coverImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage(
                height: 200,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/logo/logo.png",),
                image: NetworkImage(info.coverImage.toString(),),
              ),
            )
          : null,
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
