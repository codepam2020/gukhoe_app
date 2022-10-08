import 'dart:developer';
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
      location = position.toString();
    });
  }

  final textController = TextEditingController();

  Future clickMyLocation() async {
    getLocation();
    log(location.toString());
  }

  final testList = <Text>[Text('choco1'), Text('choco2'), Text('choco3')];

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.fromLTRB(15, 0, 10, 15),
        children: [
          Column(
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
                height: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 내 위치찾기 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: theme.main_color,
                    ),
                    onPressed: clickMyLocation,
                    child: const SizedBox(
                      width: 100,
                      height: 40,
                      child: Center(
                          child: Text(
                        '내 위치로 찾기',
                        style: theme.button_text,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                          label: Text('지역 입력'),
                          hintText: '지역을 입력하세요',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: theme.main_color, width: 2))),
                      controller: textController,
                      onChanged: (text) {
                        log('현재 텍스트 => $text');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: testList,
                  )
                ],
              )
            ],
          )
        ]);
  }
}
