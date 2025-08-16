import 'package:demo_netapp/features/user/presentation/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userVmProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('User Sample')),
      body: Center(
        child: state.when(
          data: (t) => Text(t, textAlign: TextAlign.center),
          error: (e, _) => Text('$e', textAlign: TextAlign.center),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
