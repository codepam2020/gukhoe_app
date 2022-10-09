import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gukhoe_app/screens/our_site_detailed_screen.dart';
import 'package:http/http.dart' as http;
import '../data/theme.dart';

class OurSitePage extends StatefulWidget {
  const OurSitePage({super.key});

  @override
  State<OurSitePage> createState() => _OurSitePageState();
}

class _OurSitePageState extends State<OurSitePage> {
  String? address;
  List<String> addressList = ['choco1', 'choco2', 'choco3'];
  var selectedCityNameDosi;
  var selectedCityNameSiGuGun;
  // textfield controller
  final textController = TextEditingController();

  final List<String> cityNameDosiList = ['서울시', '경기도', '강원도', '부산시'];
  final List<String> cityNameSigugunList = [
    '달서구',
    '달성군',
    '북구',
    '중구',
    '수성구',
    '동구',
    '남구'
  ];

  // 시작시 함수
  @override
  void initState() {
    super.initState();
    setState(() {
      address = 'null';
    });
  }

  void clickCancel() {
    Navigator.of(context).pop();
  }

// 위도, 경도 데이터 얻기 get Geocode
  Future getGeocode() async {
    await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return "${position.longitude},${position.latitude}";
  }

// 위도, 경도를 지역이름으로 변환 ReverseGeocode
  Future getReverseGeocode(String geocode) async {
    Map<String, String> header = {
      "X-NCP-APIGW-API-KEY-ID": "n9bs1u3zhk",
      "X-NCP-APIGW-API-KEY": "kJviXEU5xFY133CkYr0xTz16GGeY7GWE1sR2pwjn"
    };
    Uri uri = Uri.parse(
        'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$geocode&output=json');
    final response = await http.get(uri, headers: header);
    String? location =
        "${json.decode(response.body)['results'][0]['region']['area1']['name']} ${json.decode(response.body)['results'][0]['region']['area2']['name']} ${json.decode(response.body)['results'][0]['region']['area3']['name']}";

    setState(() {
      address = location;
      addressList = [location];
    });
  }

// 내 위치찾기 버튼 클릭
  Future clickMyLocationButton() async {
    var geocode = await getGeocode();
    await getReverseGeocode(geocode);
  }

  void showAlarm(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(onPressed: clickCancel, child: const Text('확인')),
            ],
          );
        });
  }

  // 국회의원 리스트 중 하나 클릭
  void clickCityName(String name) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OurSiteDetailedScreen(name: name),
    ));
  }

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
                    onPressed: clickMyLocationButton,
                    child: const SizedBox(
                      width: 130,
                      height: 42,
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

                  // TextField
                  // SizedBox(
                  //   height: 60,
                  //   child: TextField(
                  //     style: const TextStyle(fontSize: 18),
                  //     decoration: const InputDecoration(
                  //         label: Text('지역 입력'),
                  //         hintText: '지역을 입력하세요',
                  //         border: OutlineInputBorder(),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(
                  //                 color: theme.main_color, width: 2))),
                  //     controller: textController,
                  //     onChanged: (text) {
                  //       log('현재 텍스트 => $text');
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: DropdownButton(
                        hint: const Text('도 및 시를 선택하세요'),
                        isExpanded: true,
                        value: selectedCityNameDosi,
                        items: cityNameDosiList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCityNameDosi = value!;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: DropdownButton(
                        hint: const Text('지역을 선택하세요'),
                        isExpanded: true,
                        value: selectedCityNameSiGuGun,
                        items: cityNameSigugunList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: selectedCityNameDosi == null
                            ? null
                            : (value) {
                                setState(() {
                                  selectedCityNameSiGuGun = value!;
                                });
                              }),
                  ),

                  // 지역 리스트
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: addressList
                            .map((cityName) => SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      clickCityName(cityName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 8, 0, 8),
                                      child: Text(
                                        cityName,
                                        style: theme.gukhoe_list_text,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
                  )
                ],
              )
            ],
          )
        ]);
  }
}
