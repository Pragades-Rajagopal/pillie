import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/auth/services/auth_service.dart';
import 'package:pillie_app/app/components/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password do not match'),
        ),
      );
      return;
    }

    try {
      if (_formKey.currentState!.validate()) {
        await authService.signUp(email, password);
        if (mounted) Navigator.pop(context);
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
        title: const Text('Sign Up'),
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
                  const SizedBox(height: 16),
                  AppTextFormField(
                    labelText: 'Confirm Password',
                    textController: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Confirm password is mandatory with 6 char";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: register,
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
