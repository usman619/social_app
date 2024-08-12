import 'package:flutter/material.dart';
import 'package:social_app/components/app_button.dart';
import 'package:social_app/components/app_loading_circle.dart';
import 'package:social_app/components/app_password_field.dart';
import 'package:social_app/components/app_text_field.dart';
import 'package:social_app/components/hashtag_svg.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/themes/text_theme.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    showLoadingCircle(context);

    try {
      await _auth.loginEmailPassword(
          emailController.text, passwordController.text);

      if (mounted) hideLoadingCircle(context);
    } catch (e) {
      if (mounted) hideLoadingCircle(context);
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'LOGIN',
                    style: loginTextTheme(context),
                  ),
                  const SizedBox(height: 50),
                  hashtagSvg(context),
                  const SizedBox(height: 50),
                  AppTextField(
                    controller: emailController,
                    labelText: "Enter your email",
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  AppPasswordField(
                    controller: passwordController,
                    labelText: "Enter your password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: bodyTextTheme.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    text: "Login",
                    onTap: login,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not Registered Yet?',
                        style: bodyTextTheme.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.togglePage,
                        child: Text(
                          'Register Here',
                          style: bodyTextTheme.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
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
