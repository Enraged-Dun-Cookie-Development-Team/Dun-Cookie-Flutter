import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider();

  int routerIndex = 0;

  setRouterIndex(index) {
    routerIndex = index;
    notifyListeners();
  }
}
