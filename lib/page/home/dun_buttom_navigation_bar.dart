//底部栏
import 'package:dun_cookie_flutter/common/pubilc.dart';
import 'package:dun_cookie_flutter/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class DunBottomNavigationBar extends StatefulWidget {
//   DunBottomNavigationBar({Key? key, required this.commonProvider})
//       : super(key: key);
//
//   CommonProvider commonProvider;
//
//   @override
//   _DunBottomNavigationBarState createState() => _DunBottomNavigationBarState();
// }
//
// class _DunBottomNavigationBarState extends State<DunBottomNavigationBar> {
//   final List<BottomNavigationBarItem> bottomNavItems = [
//     const BottomNavigationBarItem(
//         backgroundColor: DunColors.BakeryColor,
//         icon: Image(
//           image: AssetImage("assets/logo/logo_mb@noactive.png"),
//           width: 20,
//         ),
//         activeIcon: Image(
//           image: AssetImage("assets/logo/logo_mb.png"),
//           width: 20,
//         ),
//         label: "蜜饼工坊"),
//     const BottomNavigationBarItem(
//         backgroundColor: DunColors.DunColor,
//         icon: Image(
//           image: AssetImage("assets/logo/logo@noactive.png"),
//           width: 20,
//         ),
//         activeIcon: Image(
//           image: AssetImage("assets/logo/logo.png"),
//           width: 20,
//         ),
//         label: "小刻食堂"),
//
//     const BottomNavigationBarItem(
//         backgroundColor: DunColors.DunColor,
//         icon: Icon(Icons.build, color: Colors.white),
//         activeIcon: Icon(Icons.build, color: Colors.white),
//         label: "快捷工具"),
//     // const BottomNavigationBarItem(
//     //   backgroundColor: Colors.red,
//     //   icon: Icon(Icons.settings),
//     //   label: "设置",
//     // ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: bottomNavItems,
//       currentIndex: widget.commonProvider.routerIndex,
//       type: BottomNavigationBarType.shifting,
//       iconSize: 20.0,
//       onTap: (index) {
//         if (index != widget.commonProvider.routerIndex) {
//           widget.commonProvider.setRouterIndex(index);
//         }
//       },
//     );
//   }
// }

class DunBottomNavigationBar extends StatefulWidget {
  DunBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _DunBottomNavigationBarState createState() => _DunBottomNavigationBarState();
}

class _DunBottomNavigationBarState extends State<DunBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonItem(
                index: 1,
                content: const Image(
                  image: AssetImage("assets/logo/logo_mb@noactive.png"),
                  width: 30,
                ),
                activeContent: const Image(
                  image: AssetImage("assets/logo/logo_mb.png"),
                  width: 30,
                ),
                label: "蜜饼工坊"),
            ButtonItem(
                index: 2,
                content: const Icon(Icons.settings),
                activeContent: const Icon(Icons.settings,color: DunColors.DunColor,),
                label: "常用工具"),
          ],
        ),
      ),
    );
  }
}

class ButtonItem extends StatefulWidget {
  ButtonItem(
      {Key? key,
      required this.index,
      required this.content,
      required this.activeContent,
      required this.label})
      : super(key: key);

  int index;
  Widget content;
  Widget activeContent;
  String label;

  @override
  _ButtonItemState createState() => _ButtonItemState();
}

class _ButtonItemState extends State<ButtonItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CommonProvider>(builder: (ctx, data, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTap(widget.index, data),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                child: widget.content,
                visible: data.routerIndex != widget.index,
              ),
              Visibility(
                child: widget.activeContent,
                visible: data.routerIndex == widget.index,
              ),
              Visibility(
                child: Text(widget.label),
                visible: data.routerIndex != widget.index,
              ),
              Visibility(
                child: Text(widget.label,style: TextStyle(color: DunColors.DunColor),),
                visible: data.routerIndex == widget.index,
              ),
            ],
          ),
        );
      }),
    );
  }

  _onTap(index, CommonProvider data) {
    if (index != data.routerIndex) {
      data.setRouterIndex(index);
    }
  }
}
