import 'dart:async';
import 'package:transition/transition.dart';
import 'package:flutter/material.dart';
import 'package:gukhoe_app/data/theme.dart';
import 'package:gukhoe_app/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveScreen() {
    Navigator.pushReplacement(
      context,
      Transition(
          child: const MainScreen(), transitionEffect: TransitionEffect.FADE),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: theme.main_color,
      body: Center(
          child: Text(
        'Splash Screen',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
      )),
    );
  }
}
