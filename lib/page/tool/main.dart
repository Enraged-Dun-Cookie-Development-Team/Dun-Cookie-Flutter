import 'package:dun_cookie_flutter/cache/setting_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DunTool extends StatefulWidget {
  const DunTool({Key? key}) : super(key: key);
  static String routeName = "/setting";

  @override
  State<DunTool> createState() => _DunToolState();
}

class _DunToolState extends State<DunTool> {
  bool? checkedBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("工具"),);
  }
}
