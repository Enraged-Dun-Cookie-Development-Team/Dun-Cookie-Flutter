import 'package:dun_cookie_flutter/common/debounce_throttle.dart';
import 'package:flutter/material.dart';

import '../common/dun_color.dart';

class CheckWidget extends StatefulWidget {
  final bool initialValue;

  final void Function(bool value)? callBack;

  const CheckWidget({super.key, required this.initialValue, this.callBack});

  @override
  State<StatefulWidget> createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.callBack != null) {
          widget.callBack!(!selected);
        }
        setState(() {
          selected = !selected;
        });
      },
      child: selected
          ? const Icon(
              Icons.check_box_outlined,
              size: 30,
              color: DunColors.DunColor,
            )
          : const Icon(
              Icons.check_box_outline_blank,
              size: 30,
              color: Colors.white,
            ),
    );
  }
}
