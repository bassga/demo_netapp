import 'package:demo_netapp/features/user/data/user_data_source.dart';
import 'package:demo_netapp/features/user/data/user_dto.dart';
import 'package:dio/dio.dart';

class FakeUserDataSource implements UserDataSource {
  @override
  Future<UserDto> fetchUser(int id, {CancelToken? cancel}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return UserDto(
      id: id,
      name: 'Garfield Dev',
      username: 'garfield_$id',
      email: 'g$id@example.com',
    );
  }
}
