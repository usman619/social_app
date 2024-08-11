import 'package:flutter/material.dart';
import 'package:social_app/pages/login_page.dart';
import 'package:social_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLoginPage = true;

  void togglePage() {
    setState(
      () {
        isLoginPage = !isLoginPage;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginPage(
        togglePage: togglePage,
      );
    } else {
      return RegisterPage(
        togglePage: togglePage,
      );
    }
  }
}
