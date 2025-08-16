import 'package:demo_netapp/features/user/data/user_dto.dart';
import 'package:dio/dio.dart';

abstract class UserDataSource {
  Future<UserDto> fetchUser(int id, {CancelToken? cancel});
}
