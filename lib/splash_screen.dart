import 'dart:async';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'Splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      // Use Navigator.pushReplacementNamed for named routes
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    return Scaffold(
      body: Image.asset(
        'assets/photos/splash.png',
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
