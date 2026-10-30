// Copy to config.dart for local builds. Keep environment-specific settings local.
const devEnv = false;

class HttpConfig {
  static const String serverBaseUrl = 'https://server.ceobecanteen.top/api/v1';
  static const String serveCdnBaseUrl =
      'https://server-cdn.ceobecanteen.top/api/v1';
  static const String cdnBaseUrl = 'https://cdn.ceobecanteen.top';
  static const timeout = Duration(milliseconds: 5000);
  static Map<String, dynamic> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
}
