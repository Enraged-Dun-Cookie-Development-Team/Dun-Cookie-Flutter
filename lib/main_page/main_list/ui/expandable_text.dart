
import 'package:flutter/cupertino.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int expandLimit;
  const ExpandableText({ Key? key ,required this.text,this.expandLimit=20}) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}