import '../../model/ceobe/resource/resource_info.dart';
import '../../model/cookie/cookie_count.dart';

class TerminalState {
  ResourceInfoModel resourceInfo = ResourceInfoModel.fromJson({});
  CookieInfoCountModel cookieInfoCount = CookieInfoCountModel.fromJson({});
  String rootGID = 'root';
  TerminalState() {
    ///Initialize variables
  }
}
