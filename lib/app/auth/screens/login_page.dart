import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/auth/screens/register_page.dart';
import 'package:pillie_app/app/auth/services/auth_service.dart';
import 'package:pillie_app/app/components/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      // Check if email and password text fields are not null
      if (_formKey.currentState!.validate()) {
        await authService.signIn(email, password);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pillie'),
        actions: [
          IconButton(
            onPressed: () async {
              AdaptiveThemeMode? themeMode = await AdaptiveTheme.getThemeMode();
              if (themeMode == AdaptiveThemeMode.dark) {
                AdaptiveTheme.of(context).setLight();
              } else {
                AdaptiveTheme.of(context).setDark();
              }
            },
            icon: const Icon(CupertinoIcons.thermometer),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextFormField(
                    labelText: 'Email',
                    textController: _emailController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Email is mandatory";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Password',
                    textController: _passwordController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password is mandatory with 6 char";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: login,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    ),
                    child: const Text('Register'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
