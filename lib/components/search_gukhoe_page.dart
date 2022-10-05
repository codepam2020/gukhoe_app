import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchGukhoePage extends StatefulWidget {
  const SearchGukhoePage({super.key});

  @override
  State<SearchGukhoePage> createState() => _SearchGukhoePageState();
}

class _SearchGukhoePageState extends State<SearchGukhoePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'search gukhoe',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    ));
  }
}
