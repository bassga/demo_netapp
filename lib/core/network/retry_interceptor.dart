import 'dart:math';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxAttempts;
  final Duration baseDelay;

  RetryInterceptor(
    this.dio, {
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 300),
  });

  bool _shouldRetry(DioException e) {
    final isGet = e.requestOptions.method.toUpperCase() == 'GET';
    return isGet &&
        (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.receiveTimeout);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRetry(err)) return handler.next(err);
    final attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;
    if (attempt >= maxAttempts) return handler.next(err);

    await Future.delayed(baseDelay * pow(2, attempt).toInt());
    final req = err.requestOptions.copyWith(
      extra: {...err.requestOptions.extra, 'retry_attempt': attempt + 1},
    );
    try {
      final res = await dio.fetch(req);
      return handler.resolve(res);
    } on DioException catch (e) {
      return super.onError(e, handler);
    }
  }
}
