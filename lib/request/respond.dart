class ResponseData {
  ResponseData({required this.error, required this.data, required this.msg});

  bool error = false;
  dynamic data;
  String msg = "";

  bool get isSuccess => msg == "";
}
