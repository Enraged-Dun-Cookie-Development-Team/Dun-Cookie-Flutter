import 'package:dio/dio.dart';
import 'config.dart';

class HttpClass {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
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
    if (isNoBaseUrl) {
      dio.options.baseUrl = "";
    } else {
      dio.options.baseUrl = HttpConfig.baseUrl;
    }
    try {
      Response response = await dio.request(
        url,
        queryParameters: params,
        options: options,
      );
      dio.interceptors.add(_dInter());
      return {"error": false, "data": response.data};
    } catch (e) {
      return {"error": true, "data": []};
    }
  }

  static InterceptorsWrapper _dInter() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去

        // Future<dynamic> future = Future(()async{
        //   SharedPreferences prefs =await SharedPreferences.getInstance();
        //   return prefs.getString("loginToken");
        // });
        // return future.then((value) {
        //   options.headers["Authorization"] = value;
        //   return options;
        // }).whenComplete(() => dio.unlock()); // unlock the dio
        // print(options.baseUrl + options.path);
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
