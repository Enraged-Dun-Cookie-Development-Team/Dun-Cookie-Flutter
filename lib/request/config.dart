const devEnv = true;

class HttpConfig {
  // static const jsonContentType = 'application/json;charset=utf-8';
  static const String tempBaseUrl = "https://temp.ceobecanteen.top";
  static const String ceobecanteenBaseUrl = "http://api.ceobecanteen.top";
  static const String serverBaseUrl = devEnv ? "http://server-dev.ceobecanteen.top/api/v1" : "https://server.ceobecanteen.top/api/v1";
  static const String serveCdnBaseUrl = devEnv ? "http://cdn-muelsyse-dev.ceobecanteen.top/api/v1" : "https://server-cdn.ceobecanteen.top/api/v1";
  static const String cdnBaseUrl = devEnv ? "http://cdn-dev.ceobecanteen.top" : "https://cdn.ceobecanteen.top";
  static const timeout = 5000;
  static Map<String, dynamic> headers = {
    "Content-Type": "application/json;charset=UTF-8",
  };
}
