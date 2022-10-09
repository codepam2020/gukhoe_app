import 'package:flutter/material.dart';
import 'package:gukhoe_app/data/theme.dart';
import '../components/our_site_page.dart';
import '../components/search_gukhoe_page.dart';
import '../components/gukhoe_schedule_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> mainScreenPages = [
    const OurSitePage(),
    const SearchGukhoePage(),
    const GukhoeSchedulePage()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
          child: TabBar(
            tabs: const <Widget>[
              Tab(
                height: 55,
                icon: Icon(
                  Icons.pin_drop,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
              )
            ],
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.grey.withOpacity(0.8),
            labelColor: theme.main_color,
          ),
        ),
        body: TabBarView(children: mainScreenPages),
      ),
    );
  }
}
