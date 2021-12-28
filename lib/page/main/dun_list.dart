import 'package:dun_cookie_flutter/service/main.dart';
import 'package:dun_cookie_flutter/service/main_request.dart';
import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("开始请求");
    MainRequest.test();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (ctx, index) {
        return ListTile(
          title: Text(index.toString()),
        );
      },
    );
  }
}
