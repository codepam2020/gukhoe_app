import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gukhoe_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              color: Colors.transparent,
              elevation: 0)),
      debugShowCheckedModeBanner: false,
      title: 'Guk Hoe App',
      home: const SplashScreen(),
    );
  }
}
