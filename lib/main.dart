import 'package:demo_netapp/features/user/presentation/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo NetApp',
      theme: ThemeData(useMaterial3: true),
      home: UserScreen(),
    );
  }
}
