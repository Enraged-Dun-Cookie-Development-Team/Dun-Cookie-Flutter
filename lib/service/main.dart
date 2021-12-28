import 'package:dio/dio.dart';
import 'config.dart';

class HttpClass {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    connectTimeout: HttpConfig.timeout,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  static final Dio dio = Dio();

  static Future _request(
    String url, {
    String method = "get",
    Map<String, dynamic>? params,
  }) async {
    final options = Options(method: method);
    try {
      Response response = await dio.request(
        url,
        queryParameters: params,
        options: options,
      );
      dio.interceptors.add(_dInter());
      return response.data;
    } catch (e) {
      return Future.error(e);
    }
  }

  static InterceptorsWrapper _dInter() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
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

  static Future get(String url) {
    return dio.get(url);
  }

  static Future post(String url, {Map<String, dynamic>? params}) {
    return _request(url, method: "post", params: params);
  }

  static void test(String url, {Map<String, dynamic>? params}) async {
    //todo application/json;charset:utf-8
    print("进入方法");
    Dio dio2 = Dio(BaseOptions(contentType: 'application/json'));
    print("初始化");
    Response response;
    response= await dio2.get(url);
    print(response.data.toString());
  }
}
