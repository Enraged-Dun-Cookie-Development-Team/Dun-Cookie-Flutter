import 'package:dio/dio.dart';
import 'package:flutter_logkit/logkit.dart';

class DioLogInterceptor extends Interceptor {
  final LogkitLogger logger;
  final logTag = 'DioLogInterceptor';

  DioLogInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    logger.logTyped(
      HttpRequestLogRecord.generate(
        tag: logTag,
        method: options.method,
        url: options.uri.toString(),
        headers: options.headers,
        body: options.data,
      ),
      settings: const LogSettings(printToConsole: false),
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    logger.logTyped(
      HttpResponseLogRecord.generate(
        tag: logTag,
        method: response.requestOptions.method,
        url: response.requestOptions.uri.toString(),
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        headers: response.headers.map,
        body: response.data,
      ),
      settings: const LogSettings(printToConsole: false),
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    final resp = err.response;
    logger.logTyped(
      HttpErrorLogRecord.generate(
        tag: logTag,
        method: err.requestOptions.method,
        url: err.requestOptions.uri.toString(),
        statusCode: resp?.statusCode,
        statusMessage: resp?.statusMessage,
        headers: resp?.headers.map,
        body: resp?.data,
        error: err,
      ),
    );
  }
}
