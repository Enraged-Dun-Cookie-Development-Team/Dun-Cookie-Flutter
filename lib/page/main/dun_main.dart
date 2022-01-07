import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/page/main/dun_drawer.dart';
import 'package:dun_cookie_flutter/page/main/dun_list.dart';
import 'package:dun_cookie_flutter/provider/list_source_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListSourceInfoProvider>(
            create: (_) => ListSourceInfoProvider()),
      ],
      child: Scaffold(
        appBar: _appBar,
        body: const MainList(),
        drawer: const DunDrawer(),
      ),
    );
  }

  final _appBar = AppBar(
    title: Row(
      children: const [
        Image(
          image: AssetImage("assets/logo/logo.png"),
          height: 30,
        ),
        SizedBox(
          width: 5,
        ),
        Text("小刻食堂 alpha"),
      ],
    ),
  );
}
