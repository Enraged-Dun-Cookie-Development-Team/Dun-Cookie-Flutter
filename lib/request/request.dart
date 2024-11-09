import 'package:dio/dio.dart';

import '../manager/settingManager.dart';
import '../model/json.dart';
import 'config.dart';
import 'respond.dart';

enum RequestType {
  server,
  serveCdn,
  cdn,
  none,
}

class HttpClass {
  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: HttpConfig.timeout,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  static final Dio dio = Dio(_baseOptions);

  static Future<ResponseData<T>> _request<T>(
    String url, {
    required MapToModel<T> fromJson,
    String method = "get",
    Map<String, dynamic>? params,
    data,
    RequestType type = RequestType.none,
  }) async {
    final options = Options(method: method);
    switch (type) {
      case RequestType.none:
        dio.options.baseUrl = "";
        break;
      case RequestType.server:
        dio.options.baseUrl = HttpConfig.serverBaseUrl;
        break;
      case RequestType.serveCdn:
        dio.options.baseUrl = HttpConfig.serveCdnBaseUrl;
        break;
      case RequestType.cdn:
        dio.options.baseUrl = HttpConfig.cdnBaseUrl;
        break;
    }
    try {
      dio.options.headers.addAll({
        "mob-id": SettingManager.getInstance().rid,
      });
      print("请求 ${dio.options.baseUrl}$url");
      Response response = await dio.request(
        url,
        queryParameters: params,
        data: data,
        options: options,
      );
      return ResponseData<T>(
          error: false,
          data: response.data,
          msg: "",
          fromJson: fromJson,
          type: type);
    } on DioException catch (e) {
      return ResponseData<T>(
          error: true,
          data: e.response?.data,
          msg: e.message ?? '',
          fromJson: fromJson);
    }
  }

  static Future<ResponseData<T>> get<T>(
    String url, {
    params,
    RequestType type = RequestType.none,
    required MapToModel<T> fromJson,
  }) {
    return _request<T>(url, params: params, type: type, fromJson: fromJson);
  }

  static Future<ResponseData<T>> post<T>(
    String url, {
    Map<String, dynamic>? params,
    data,
    RequestType type = RequestType.none,
    required MapToModel<T> fromJson,
  }) {
    return _request<T>(url,
        method: "post",
        params: params,
        data: data,
        type: type,
        fromJson: fromJson);
  }
}
