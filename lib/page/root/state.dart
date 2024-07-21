import 'package:dun_cookie_flutter/page/cookies/view.dart';
import 'package:dun_cookie_flutter/page/more/view.dart';
import 'package:dun_cookie_flutter/page/terminal/view.dart';
import 'package:dun_cookie_flutter/widget/scroll_hide.dart';
import 'package:flutter/widgets.dart';

class RootState {
  int currentPageIndex = 0;

  List<Widget> pageList = [
    const CookiesPage(),
    const MorePage(),
    const TerminalPage(),
  ];

  final scrollHideController = ScrollHideController();
}
