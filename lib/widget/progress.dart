import 'package:flutter/widgets.dart';

class ProgressController extends ChangeNotifier {
  int _count = 0;
  int _total = 0;

  ProgressController({int count = 0, int total = 0}) {
    _count = count;
    _total = total;
  }

  set count(int value) {
    _count = value;
    notifyListeners();
  }

  set total(int value) {
    _total = value;
    notifyListeners();
  }

  int get count => _count;
  int get total => _total;
  double get percent => total == 0 ? 0 : (count / total).clamp(0, 1);
}

class ProgressBuilder extends StatelessWidget {
  const ProgressBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });
  final ProgressController controller;
  final Widget Function(
      BuildContext context, int count, int total, double percent) builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => builder(
        context,
        controller.count,
        controller.total,
        controller.percent,
      ),
    );
  }
}
