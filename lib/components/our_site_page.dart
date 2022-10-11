import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gukhoe_app/screens/our_site_detailed_screen.dart';
import 'package:gukhoe_app/utils/show_alarm.dart';
import 'package:http/http.dart' as http;
import '../data/theme.dart';
import '../utils/get_map_data.dart';

class OurSitePage extends StatefulWidget {
  const OurSitePage({super.key});

  @override
  State<OurSitePage> createState() => _OurSitePageState();
}

class _OurSitePageState extends State<OurSitePage> {
  String? address;
  List<String> addressList = ['choco1', 'choco2', 'choco3'];
  var selectedCityName1;
  var selectedCityName2;
  // textfield controller
  final textController = TextEditingController();

  final List<String> cityNameList1 = [
    '서울특별시',
    '인천광역시',
    '부산광역시',
    '대구광역시',
    '울산광역시',
    '광주광역시',
    '제주특별자치도',
    '세종특별자치시',
    '경기도',
    '강원도',
    '충청북도',
    '충청남도',
    '경상북도',
    '경상남도',
    '전라북도',
    '전라남도'
  ];
  final List<String> cityNameList2 = [
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

// 내 위치찾기 버튼 클릭
  Future clickMyLocationButton() async {
    var geocode = await MapData.getGeocode(context);
    var location = await MapData.getReverseGeocode(geocode);
    setState(() {
      // address = location;
      // addressList = <String>[location];
    });
    showAlarm(context, '위치 확인', location);
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
        padding: const EdgeInsets.fromLTRB(15, 20, 10, 15),
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
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
                        hint: const Text('도 및 시를 선택하세요'),
                        isExpanded: true,
                        value: selectedCityName1,
                        items: cityNameList1.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCityName1 = value!;
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
                        value: selectedCityName2,
                        items: cityNameList2.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: selectedCityName1 == null
                            ? null
                            : (value) {
                                setState(() {
                                  selectedCityName2 = value!;
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
