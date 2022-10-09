import 'package:flutter/material.dart';
import 'package:gukhoe_app/data/theme.dart';

class OurSiteDetailedScreen extends StatefulWidget {
  final String name;
  const OurSiteDetailedScreen({super.key, required this.name});

  @override
  State<OurSiteDetailedScreen> createState() => _OurSiteDetailedScreenState();
}

class _OurSiteDetailedScreenState extends State<OurSiteDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.main_color,
        title: Text(widget.name),
      ),
    );
  }
}
