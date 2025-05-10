import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/auth/screens/auth_gate.dart';
import 'package:pillie_app/clients/supabase_init.dart';
import 'package:pillie_app/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, themeDark) {
        return MaterialApp(
          theme: theme,
          darkTheme: themeDark,
          debugShowCheckedModeBanner: false,
          home: const AuthGate(),
        );
      },
    );
  }
}
