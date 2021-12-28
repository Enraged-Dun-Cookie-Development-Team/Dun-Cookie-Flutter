class HttpConfig {
  // static const jsonContentType = 'application/json;charset=utf-8';
  static const String baseUrl = "http://81.68.101.79:3000";
  static const timeout = 5000;
  static Map<String, dynamic> headers = {
    "Content-Type": "application/json;charset=UTF-8",
  };
}
