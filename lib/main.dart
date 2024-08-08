import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home_page.dart';
import 'package:social_app/pages/login_page.dart';
import 'package:social_app/pages/settings_page.dart';
import 'package:social_app/themes/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const LoginPage(),
    );
  }
}
