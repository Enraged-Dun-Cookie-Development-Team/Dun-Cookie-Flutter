import 'package:flutter/material.dart';

class ExpendText extends StatefulWidget {
  final String text;
  final int maxLines;
  final int minLines;
  final TextStyle? textStyle;
  final String shrinkText;
  final String expandText;
  final Function? onShrink;
  final Function? onExpand;

  const ExpendText(
      {super.key,
      this.text = '',
      this.maxLines = 4,
      this.minLines = 1,
      this.textStyle,
      this.shrinkText = '展开',
      this.expandText = '收起',
      this.onShrink,
      this.onExpand});

  @override
  State<ExpendText> createState() => _ExpendTextState();
}

class _ExpendTextState extends State<ExpendText> {
  bool _isExpand = true;

  @override
  void initState() {
    super.initState();
  }

  void changeState() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  @override
  void didUpdateWidget(covariant ExpendText oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      TextPainter textPainter = TextPainter(
          maxLines: widget.maxLines,
          textScaler: MediaQuery.textScalerOf(context),
          locale: Localizations.localeOf(context),
          textAlign: TextAlign.start,
          text: TextSpan(
            text: widget.text,
            style: widget.textStyle,
          ),
          textDirection: Directionality.of(context))
        ..layout(
            minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
      // 判断是否已经超过最大行数
      if (textPainter.didExceedMaxLines) {
        final textSize = textPainter.size;
        final position = textPainter.getPositionForOffset(Offset(
          textSize.width - textPainter.width,
          textSize.height,
        ));
        // 默认endOffset = position.offset -1;但是这样导致展开两字有时会换行，故再减了1
        final endOffset = textPainter.getOffsetBefore(position.offset - 1);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  // 截取 0-endOffset 的字符串，再在后面拼接展开/收起
                  text: !_isExpand
                      ? widget.text
                      : widget.text.substring(0, endOffset),
                  style: widget.textStyle,
                )),
            GestureDetector(
              onTap: changeState,
              child: Text(
                _isExpand ? widget.shrinkText : widget.expandText,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      } else {
        return Text.rich(TextSpan(text: widget.text, style: widget.textStyle));
      }
    });
  }
}
