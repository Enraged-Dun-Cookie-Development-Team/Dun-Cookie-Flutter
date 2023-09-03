import 'package:dio/dio.dart';
import 'package:dun_cookie_flutter/common/constant/main.dart';

import 'config.dart';

class HttpClass {
  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: HttpConfig.timeout,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  static final Dio dio = Dio(_baseOptions);

  static Future _request(
    String url, {
    String method = "get",
    Map<String, dynamic>? params,
    data,
    int? type,
  }) async {
    final options = Options(method: method);
    switch (type) {
      case -1:
        dio.options.baseUrl = "";
        break;
      case 0:
        dio.options.baseUrl = HttpConfig.tempBaseUrl;
        break;
      case 1:
        dio.options.baseUrl = HttpConfig.serverBaseUrl;
        break;
      case 2:
        dio.options.baseUrl = HttpConfig.ceobecanteenBaseUrl;
        break;
      case 3:
        dio.options.baseUrl = HttpConfig.serveCdnBaseUrl;
        break;
      case 4:
        dio.options.baseUrl = HttpConfig.cdnBaseUrl;
        break;
    }
    try {
      dio.options.headers.addAll({
        "mob-id": Constant.mobRId,
      });
      print("请求 ${dio.options.baseUrl}$url");
      Response response = await dio.request(
        url,
        queryParameters: params,
        data: data,
        options: options,
      );
      return ResponseData(false, response.data, "");
    } catch (e) {
      return ResponseData(true, null, e.toString());
    }
  }

  static InterceptorsWrapper _dInter() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({"MobRId": Constant.mobRId});
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError err, handler) async {
        return handler.next(err);
      },
    );
  }

  static Future get(String url, {params, type = 0}) {
    return _request(url, params: params, type: type);
  }

  static Future post(String url,
      {Map<String, dynamic>? params, data, type = 0}) {
    return _request(url,
        method: "post", params: params, data: data, type: type);
  }
}

class ResponseData {
  ResponseData(this.error, this.data, this.msg);

  bool error = false;
  dynamic data;
  String msg = "";

  bool isSuccess() => msg == "";
}
