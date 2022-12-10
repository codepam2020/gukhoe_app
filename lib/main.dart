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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 165, 165, 165),
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
