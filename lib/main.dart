import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'styles/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart City León',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
    );
  }
}
