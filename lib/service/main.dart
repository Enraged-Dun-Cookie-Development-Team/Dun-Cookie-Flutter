import 'package:dio/dio.dart';
import 'package:dun_cookie_flutter/common/static_variable/main.dart';
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
    bool isNoBaseUrl = false,
  }) async {
    final options = Options(method: method);
    isNoBaseUrl
        ? dio.options.baseUrl = ""
        : dio.options.baseUrl = HttpConfig.baseUrl;
    try {
      dio.interceptors.add(_dInter());
      Response response = await dio.request(
        url,
        queryParameters: params,
        options: options,
      );
      return {"error": false, "data": response.data};
    } catch (e) {
      return {"error": true, "data": []};
    }
  }

  static InterceptorsWrapper _dInter() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (StaticVariable.deviceId == null) {
          dio.lock();
          eventBus.on<DeviceInfoBus>().listen((_) => dio.unlock());
        }
        options.headers.addAll({"deviceID": StaticVariable.deviceId});
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response != null) {
          return handler.next(response);
        } else {
          return;
        }
      },
      onError: (DioError err, handler) async {
        return handler.next(err);
      },
    );
  }

  static Future get(String url, {params}) {
    return _request(url, params: params);
  }

  static Future tempGet(String url) {
    return _request(url, isNoBaseUrl: true);
  }

  static Future post(String url, {Map<String, dynamic>? params}) {
    return _request(url, method: "post", params: params);
  }
}
