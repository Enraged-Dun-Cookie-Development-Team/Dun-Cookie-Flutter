import 'package:flutter/cupertino.dart';

class SettingCache extends ChangeNotifier {
  bool _isShowShabi = false;

  bool get isShowShabi => _isShowShabi;

  set isShowShabi(bool value) {
    _isShowShabi = value;
    notifyListeners();
  }
}
