import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../data/theme.dart';

class OurSitePage extends StatefulWidget {
  const OurSitePage({super.key});

  @override
  State<OurSitePage> createState() => _OurSitePageState();
}

class _OurSitePageState extends State<OurSitePage> {
  String? location;
  @override
  void initState() {
    super.initState();
    location = '비어있음';
  }

  Future<void> getLocation() async {
    await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      location = position.latitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: theme.page_title_box_height,
            child: Row(
              children: const <Widget>[
                Text(
                  '내 지역 국회의원',
                  style: theme.page_title_text,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column()
        ],
      ),
    );
  }
}
