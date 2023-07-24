import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int expandLimit;

  const ExpandableText(this.text, {Key? key, this.style, this.expandLimit = 20})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final bool needExpand;
    if (box == null) {
      needExpand = true;
    } else {
      final width = box.size.width;
      final text = TextPainter(
          text: TextSpan(text: widget.text), maxLines: widget.expandLimit);
      text.layout(maxWidth: width);
      needExpand = text.didExceedMaxLines;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style,
          maxLines: isExpand ? null : widget.expandLimit,
          overflow: TextOverflow.fade,
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
