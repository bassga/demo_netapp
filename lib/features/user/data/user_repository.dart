import 'package:demo_netapp/config/app_env.dart';
import 'package:demo_netapp/core/network/api_client.dart';
import 'package:demo_netapp/core/network/dio_provider.dart';
import 'package:demo_netapp/features/user/data/fake_user_data_source.dart';
import 'package:demo_netapp/features/user/data/remote_user_data_source.dart';
import 'package:demo_netapp/features/user/data/user_data_source.dart';
import 'package:demo_netapp/features/user/data/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {
  final UserDataSource _ds;
  UserRepository(this._ds);

  Future<UserDto> getUser(int id, {CancelToken? cancel}) {
    return _ds.fetchUser(id, cancel: cancel);
  }
}

@riverpod
UserRepository userRepository(Ref ref) {
  final env = ref.watch(envProvider);
  if (env.useFake) {
    return UserRepository(FakeUserDataSource());
  } else {
    final dio = ref.watch(dioProvider);
    final api = ApiClient(dio);
    return UserRepository(RemoteUserDataSource(api));
  }
}
