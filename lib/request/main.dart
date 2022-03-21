import 'package:dio/dio.dart';
import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:provider/provider.dart';
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
    int? type,
  }) async {
    final options = Options(method: method);
    switch (type) {
      case -1:
        dio.options.baseUrl = "";
        break;
      case 0:
        dio.options.baseUrl = HttpConfig.lwtBaseUrl;
        break;
      case 1:
        dio.options.baseUrl = HttpConfig.wyqBaseUrl;
        break;
      case 2:
        dio.options.baseUrl = HttpConfig.ceobecanteenBaseUrl;
        break;
    }
    try {
      dio.interceptors.add(_dInter());
      Response response = await dio.request(
        url,
        queryParameters: params,
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
        if (Constant.jpushRid == null) {
          dio.lock();
          eventBus.on<DeviceInfoBus>().listen((_) => dio.unlock());
        }
        options.headers.addAll({"JPushRid": Constant.jpushRid});
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

  static Future post(String url, {Map<String, dynamic>? params, type = 0}) {
    return _request(url, method: "post", params: params, type: type);
  }
}

class ResponseData {
  ResponseData(this.error, this.data, this.msg);

  bool error = false;
  dynamic data;
  String msg = "";
}
