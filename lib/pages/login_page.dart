import 'package:flutter/material.dart';
import 'package:social_app/components/app_button.dart';
import 'package:social_app/components/app_password_field.dart';
import 'package:social_app/components/app_text_field.dart';
import 'package:social_app/components/hashtag_svg.dart';
import 'package:social_app/themes/text_theme.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  'LOGIN PAGE',
                  style: loginTextTheme(context),
                ),
                const SizedBox(height: 20),
                hashtagSvg(context),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: bodyTextTheme,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  text: "Login",
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not Registered Yet?',
                      style: bodyTextTheme.copyWith(
                        color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
