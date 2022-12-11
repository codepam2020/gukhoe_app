import 'package:flutter/material.dart';
import 'package:gukhoe_app/data/theme.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Test Screen'),
        ),
        body: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: const Text('Test',
                    style: TextStyle(
                        fontSize: 60,
                        color: theme.main_color,
                        fontWeight: FontWeight.bold)),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'data',
                  style: TextStyle(
                      fontSize: 60,
                      color: theme.main_color,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }
}
