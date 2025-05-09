import 'package:flutter/material.dart';
import 'package:pillie_app/auth/screens/auth_gate.dart';
import 'package:pillie_app/clients/supabase_init.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
    );
  }
}
