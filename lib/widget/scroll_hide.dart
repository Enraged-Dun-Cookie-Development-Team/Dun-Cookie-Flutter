import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollHideController {
  final _isHidden = ValueNotifier(false);
  bool get isHidden => _isHidden.value;

  void addScrollController(ScrollController controller) {
    controller.addListener(() {
      switch (controller.position.userScrollDirection) {
        case ScrollDirection.forward:
          _show();
          break;
        case ScrollDirection.reverse:
          _hide();
          break;
        default:
        // nothing
      }
    });
  }

  void _hide() {
    if (isHidden) return;
    _isHidden.value = true;
  }

  void _show() {
    if (!isHidden) return;
    _isHidden.value = false;
  }

  void dispose() {
    _isHidden.dispose();
  }
}

class ScrollHideWidget extends StatelessWidget {
  const ScrollHideWidget({
    super.key,
    required this.controller,
    required this.child,
    this.builder,
  });
  final ScrollHideController controller;
  final Widget child;
  final Widget Function(BuildContext context, Widget child, bool isHidden)?
      builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller._isHidden,
      builder: (context, child) {
        return builder != null
            ? builder!(context, this.child, controller.isHidden)
            : IgnorePointer(
                ignoring: controller.isHidden,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: controller.isHidden ? 0 : 1,
                  child: child,
                ),
              );
      },
      child: child,
    );
  }
}
