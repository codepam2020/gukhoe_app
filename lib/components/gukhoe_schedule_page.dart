import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GukhoeSchedulePage extends StatefulWidget {
  const GukhoeSchedulePage({super.key});

  @override
  State<GukhoeSchedulePage> createState() => _GukhoeSchedulePageState();
}

class _GukhoeSchedulePageState extends State<GukhoeSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'schedule',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ));
  }
}
