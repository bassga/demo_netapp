import 'package:dio/dio.dart';

import 'failure.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Never _throwMapped(DioException e) {
    final s = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw const AppFailure(FailureType.timeout, message: 'Timeout');

      case DioExceptionType.cancel:
        throw const AppFailure(FailureType.cancel, message: 'Canceled');

      case DioExceptionType.connectionError:
        throw const AppFailure(FailureType.network, message: 'Network error');

      default:
        if (s == 401) {
          throw const AppFailure(
            FailureType.unauthorized,
            message: 'Unauthorized',
            status: 401,
          );
        }
        if (s != null && s >= 500) {
          throw AppFailure(
            FailureType.server,
            message: 'Server error',
            status: s,
          );
        }
        throw AppFailure(
          FailureType.unknown,
          message: e.message ?? 'Unknown',
          status: s,
        );
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: query,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      _throwMapped(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: query,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      _throwMapped(e);
    }
  }
}
