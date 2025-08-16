import 'package:demo_netapp/features/user/data/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_vm.g.dart';

@riverpod
class UserVm extends _$UserVm {
  CancelToken? _cancel;

  Future<String> build() async {
    _cancel = CancelToken();
    ref.onDispose(() {
      _cancel?.cancel('dispose');
      _cancel = null;
    });

    final repo = ref.watch(userRepositoryProvider);
    final u = await repo.getUser(1, cancel: _cancel);

    return '${u.name} (@${u.username}) \n${u.email}';
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _cancel?.cancel('refresh');
      _cancel = CancelToken();
      final repo = ref.read(userRepositoryProvider);
      final u = await repo.getUser(1, cancel: _cancel);
      return '${u.name} (@${u.username}) \n${u.email}';
    });
  }
}
