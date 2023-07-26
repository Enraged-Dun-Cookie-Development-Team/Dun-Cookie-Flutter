import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final bool noExpandButton;
  final TextStyle? style;
  final int expandLimit;
  final TextOverflow overflow;

  const ExpandableText(this.text,
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
  late final bool needExpand;

  @override
  void initState() {
    super.initState();

    final probablyLines = widget.text
        .split('\n')
        .map((e) => e.length ~/ 32 + 1)
        .reduce((value, element) => value + element);
    needExpand = probablyLines > widget.expandLimit && !widget.noExpandButton;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
