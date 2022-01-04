import 'dart:async';
import 'package:flutter/material.dart';

class KazeBody extends StatefulWidget {
  KazeBody({Key? key}) : super(key: key);

  @override
  _KazeBodyState createState() => _KazeBodyState();
}

class _KazeBodyState extends State<KazeBody> {
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 400,
        child: Column(
          children: [CardTitle(), CardBody()],
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  const CardTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("官方哔哩哔哩账号"),
        subtitle: Text("2021-12-25 11:25:48"),
        leading: Image.asset(
          "assets/source_logo/bili.ico",
          width: 40,
        ),
        trailing: Icon(Icons.share));
  }
}

class CardBody extends StatefulWidget {
  const CardBody({Key? key}) : super(key: key);

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.red,
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                    text:
                        "塞壬唱片-MSR特邀@CubesCollective ，共同记录干员们的冬日闲暇。\n\n正式曲目已于2021年12月24日上线塞壬唱片官网及网易云音乐等平台",
                  ),
                  TextSpan(
                      text: "详情", style: TextStyle(color: Colors.lightBlue))
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            margin: EdgeInsets.only(top: 10),
            child: Image(
              image: NetworkImage(
                  "https://i1.hdslb.com/bfs/archive/76ea616cc1506db811bb74e0fe822c604b62f95e.jpg"),
            ),
          )
        ],
      ),
    );
  }
}
