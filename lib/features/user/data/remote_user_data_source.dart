import 'package:demo_netapp/core/network/api_client.dart';
import 'package:demo_netapp/features/user/data/user_data_source.dart';
import 'package:demo_netapp/features/user/data/user_dto.dart';
import 'package:dio/dio.dart';

class RemoteUserDataSource implements UserDataSource {
  final ApiClient _api;
  RemoteUserDataSource(this._api);

  @override
  Future<UserDto> fetchUser(int id, {CancelToken? cancel}) async {
    final res = await _api.get<Map<String, dynamic>>(
      '/users/$id',
      cancelToken: cancel,
    );
    return UserDto.fromJson(res.data!);
  }
}
