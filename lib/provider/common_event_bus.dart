import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:event_bus/event_bus.dart';

class CommonEventBus {}

EventBus eventBus = EventBus();

class DunShareImageIsShare {
  DunShareImageIsShare(this.dunShareImageIsShare);

  bool dunShareImageIsShare;
}

class DeviceInfoBus {}

class CheckSourceBus {
  CheckSourceBus(this.list);

  List<String> list;
}
