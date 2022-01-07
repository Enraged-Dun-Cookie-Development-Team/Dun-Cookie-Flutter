import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/list_source_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DunDrawer extends StatelessWidget {
  const DunDrawer({Key? key}) : super(key: key);
  static final _sourceList = SourceList.getSourceList();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 150,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: UnconstrainedBox(
                child: Text(
                  "展示类别调整",
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Consumer<ListSourceInfoProvider>(
                builder: (ctx, data, child) {
                  return ListView.builder(
                    itemCount: DunDrawer._sourceList.length,
                    itemBuilder: (ctx, index) {
                      SourceInfo info = DunDrawer._sourceList[index]["data"];
                      return SourceListTile(index, info: info, data: data);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SourceListTile extends StatefulWidget {
  const SourceListTile(this.index,
      {Key? key, required this.info, required this.data})
      : super(key: key);

  final int index;
  final SourceInfo info;
  final ListSourceInfoProvider data;

  @override
  _SourceListTileState createState() => _SourceListTileState();
}

class _SourceListTileState extends State<SourceListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<Color?> _colorAnimate;
  late final Animation<double> _opacityAnimate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _colorAnimate = ColorTween(begin: Colors.black12, end: Colors.black)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacityAnimate = Tween<double>(begin: 0.3, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    widget.data.getCheckListInPriority().then((_) {
      if (widget.data.checkSource.any((x) => x == widget.index.toString())) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AnimatedBuilder(
            animation: _opacityAnimate,
            builder: (BuildContext context, Widget? child) {
              return Image.asset(
                widget.info.icon,
                width: 30,
                opacity: _opacityAnimate,
              );
            }),
      ),
      title: AnimatedBuilder(
        animation: _colorAnimate,
        builder: (BuildContext context, Widget? child) {
          return Text(
            widget.info.title,
            style: TextStyle(color: _colorAnimate.value),
          );
        },
      ),
      trailing: Checkbox(
        value: widget.data.checkSource.any((x) => x == widget.index.toString()),
        onChanged: (value) {
          if (value!) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          widget.data.setCheckListInPriority(widget.index.toString(), value);
        },
      ),
    );
  }
}
