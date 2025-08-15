import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_env.g.dart';

class AppEnv {
  final String env; // dev/stg/prod
  final String baseUrl;
  final bool useFake;

  const AppEnv({
    required this.env,
    required this.baseUrl,
    required this.useFake,
  });
}

@riverpod
AppEnv env(Ref ref) {
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');

  const base = String.fromEnvironment('API_BASE_URL', defaultValue: '');

  const fakeStr = String.fromEnvironment('USE_FAKE', defaultValue: 'true');
  final useFake = fakeStr.toLowerCase() == 'true';

  if (!useFake && base.isEmpty) {
    throw StateError('API_BASE_URL is required unless USE_FAKE=true');
  }

  return AppEnv(env: env, baseUrl: base, useFake: useFake);
}
