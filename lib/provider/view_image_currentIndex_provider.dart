import 'package:flutter/material.dart';

class ViewImageCurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;

  ViewImageCurrentIndexProvider(this.currentIndex);


  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
