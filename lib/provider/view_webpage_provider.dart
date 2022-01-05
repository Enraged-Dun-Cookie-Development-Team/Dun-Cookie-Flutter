import 'package:flutter/material.dart';

class ViewWebPageProvider with ChangeNotifier {
  bool loadSuccess = false;
  int loadProgress = 0;
  String title = "";
  String url = "";

  ViewWebPageProvider({loadSuccess, loadProgress, title, url});

  setSuccess(value) {
    loadSuccess = value;
    notifyListeners();
  }

  setProgress(value) {
    loadProgress = value;
    notifyListeners();
  }

  setTitle(value) {
    title = value;
    notifyListeners();
  }

  setUrl(value) {
    url = value;
    notifyListeners();
  }
}
