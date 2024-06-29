import 'package:flutter/material.dart';

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <Widget>[],
  });

  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final Clip clipBehavior;
  final StackFit sizing;
  final int? index;
  final List<Widget> children;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  List<Widget> views = [];

  @override
  void initState() {
    super.initState();
    _initViews();
  }

  _initViews() {
    views = List.generate(widget.children.length, (index) => const SizedBox());
    _loadView(widget.index);
  }

  _loadView(int? index) {
    final viewIndex = index ?? 0;
    if (0 <= viewIndex && viewIndex <= widget.children.length) {
      views[viewIndex] = widget.children[viewIndex];
    }
  }

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children.length != widget.children.length) {
      _initViews();
    } else {
      _loadView(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      clipBehavior: widget.clipBehavior,
      sizing: widget.sizing,
      index: widget.index,
      children: views,
    );
  }
}
