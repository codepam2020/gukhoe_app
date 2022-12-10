import 'package:flutter/material.dart';

class SearchGukhoePage extends StatefulWidget {
  const SearchGukhoePage({super.key});

  @override
  State<SearchGukhoePage> createState() => _SearchGukhoePageState();
}

class _SearchGukhoePageState extends State<SearchGukhoePage> {
  late String name;

  @override
  void initState() {
    super.initState();
    name = '';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        TextField(
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        )
      ],
    ));
  }
}
