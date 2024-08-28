import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/services/auth/auth_gate.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/theme_provider.dart';

void main() async {
  // Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the App with the Theme Provider and Database Provider
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => DatabaseProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
