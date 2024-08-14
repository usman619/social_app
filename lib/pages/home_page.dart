import 'package:flutter/material.dart';
import 'package:social_app/components/app_drawer.dart';
import 'package:social_app/themes/text_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Home Page', style: titleTextTheme),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: const Center(
        child: Text('Welcome to the Home Page'),
      ),
    );
  }
}
