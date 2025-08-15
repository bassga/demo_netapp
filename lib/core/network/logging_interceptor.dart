import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final _log = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      _log.i('[REQUEST] ${options.method} ${options.baseUrl}');
      _log.i('Headers: ${options.headers}');
      _log.i('Query Parameters: ${options.queryParameters}');
      _log.i('Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _log.i('[RES] ${response.statusCode} ${response.requestOptions.uri}');
      _log.d('Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      _log.e('[ERR] ${err.type} ${err.requestOptions.uri} ${err.message}');
    }
    handler.next(err);
  }
}
