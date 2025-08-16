import 'package:demo_netapp/config/app_env.dart';
import 'package:demo_netapp/core/network/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final env = ref.watch(envProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: const {
        'Accept': 'application/json',
        'User-Agent': 'demo_netapp/0.1 (+flutter; dio)',
      },
      validateStatus: (status) =>
          status != null && status >= 200 && status < 600,
    ),
  );

  dio.interceptors.add(LoggingInterceptor());

  return dio;
}
