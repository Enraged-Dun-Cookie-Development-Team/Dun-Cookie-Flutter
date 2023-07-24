import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final bool noExpandButton;
  final TextStyle? style;
  final int expandLimit;

  const ExpandableText(this.text, {Key? key, this.style, this.expandLimit = 16,this.noExpandButton=false})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final needExpand = (widget.text.split('\n').length > widget.expandLimit ||
        widget.text.length > widget.expandLimit * 32) && !widget.noExpandButton;

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
