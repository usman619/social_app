import 'package:flutter/material.dart';
import 'package:social_app/components/app_button.dart';
import 'package:social_app/components/app_loading_circle.dart';
import 'package:social_app/components/app_password_field.dart';
import 'package:social_app/components/app_text_field.dart';
import 'package:social_app/components/hashtag_svg.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_service.dart';
import 'package:social_app/themes/text_theme.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;
  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final _db = DatabaseService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register() async {
    if (passwordController.text == confirmPasswordController.text) {
      showLoadingCircle(context);
      try {
        await _auth.registerEmailPassword(
          emailController.text,
          passwordController.text,
        );

        if (mounted) hideLoadingCircle(context);
        _db.saveUserInfoFirebase(
          name: nameController.text,
          email: emailController.text,
        );
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  hashtagSvg(context),
                  const SizedBox(height: 20),
                  Text(
                    'Create an Account',
                    style: titleTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: nameController,
                    labelText: "Enter your name",
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
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
                  AppPasswordField(
                    controller: confirmPasswordController,
                    labelText: "Confirm your password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    text: "Register",
                    onTap: register,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: bodyTextTheme.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.togglePage,
                        child: Text(
                          'Login',
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
