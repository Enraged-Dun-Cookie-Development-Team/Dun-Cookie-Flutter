import 'package:flutter/widgets.dart';

import '../../widget/scroll_hide.dart';
import '../cookies/view.dart';
import '../more/view.dart';
import '../terminal/view.dart';

class RootState {
  int currentPageIndex = 0;
  int launchCount = 0;

  List<Widget> pageList = [
    const CookiesPage(),
    const MorePage(),
    const TerminalPage(),
  ];

  final scrollHideController = ScrollHideController();
}
