import 'package:flutter/material.dart';
import 'package:social_app/components/app_button.dart';
import 'package:social_app/components/app_text_field.dart';
import 'package:social_app/components/hashtag_svg.dart';
import 'package:social_app/themes/text_theme.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;
  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                    controller: emailController,
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
                  AppTextField(
                    controller: passwordController,
                    labelText: "Enter your password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: confirmPasswordController,
                    labelText: "Confirm your password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    text: "Register",
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
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
