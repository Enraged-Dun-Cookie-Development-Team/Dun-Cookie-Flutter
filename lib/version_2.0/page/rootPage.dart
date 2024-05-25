import 'package:dun_cookie_flutter/version_2.0/page/home/view.dart';
import 'package:flutter/material.dart';

import '../../common/tool/color_theme.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // 当前子项索引
  int currentIndex = 0;

  // 控制器
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          body: Container(
              color: gray_3,
              padding: EdgeInsets.only(top: paddingTop),
              child: Stack(
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    // 设置控制器
                    controller: _controller,
                    // 设置子项集
                    children: [HomePage()],
                  ),
                  ..._buildBottomBar(),
                ],
              ))),
    );
  }

  List<Widget> _buildBottomBar() {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.only(bottom: paddingBottom),
          height: 60 + paddingBottom,
          decoration: const BoxDecoration(color: white, boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0.0, 0.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            )
          ]),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    currentIndex = 1;
                    _controller.jumpToPage(currentIndex);
                  }),
                  child: Image.asset(
                    'assets/icon/more_list_icon.png',
                    width: 30,
                    height: 30,
                    color: currentIndex == 1 ? yellow : gray_2,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    currentIndex = 2;
                    _controller.jumpToPage(currentIndex);
                  }),
                  child: Image.asset(
                    'assets/icon/terminal_page_icon.png',
                    width: 30,
                    height: 30,
                    color: currentIndex == 2 ? yellow : gray_2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
          padding: EdgeInsets.only(bottom: paddingBottom),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => setState(() {
                currentIndex = 0;
                _controller.jumpToPage(currentIndex);
              }),
              child: Container(
                width: 83,
                height: 83,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: currentIndex == 0 ? yellow : gray_2,
                    width: 2,
                  ),
                  color: currentIndex == 0 ? yellow : white,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icon/main_list_icon.png',
                    width: 57,
                    height: 48,
                    color: currentIndex == 0 ? white : gray_2,
                  ),
                ),
              ),
            ),
          ))
    ];
  }
}
