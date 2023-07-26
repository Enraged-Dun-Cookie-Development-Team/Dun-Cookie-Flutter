import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final bool noExpandButton;
  final TextStyle? style;
  final int expandLimit;
  final TextOverflow overflow;

  ExpandableText(this.text,
      {Key? key,
      this.style,
      this.expandLimit = 16,
      this.noExpandButton = false,
      this.overflow = TextOverflow.fade})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpand = false;
  bool needExpand = true;
  double? lastWidth;

  final GlobalKey globalKey = GlobalKey();

  _checkNeedExpand(_) {
    if (globalKey.currentContext != null) {
      var width = globalKey.currentContext!.size!.width;
      // 宽度无变化，不变
      if (lastWidth != null && lastWidth == width) {
        return;
      }
      var render = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: widget.expandLimit,
          textDirection: TextDirection.ltr);
      render.layout(maxWidth: width);

      needExpand = render.didExceedMaxLines;
      lastWidth = width;
    }
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(_checkNeedExpand);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ExpandableText oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback(_checkNeedExpand);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: globalKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style,
          maxLines: isExpand ? null : widget.expandLimit,
          overflow: widget.overflow,
        ),
        if (needExpand)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Text(
              isExpand ? "收起" : "展开",
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          )
      ],
    );
  }
}
