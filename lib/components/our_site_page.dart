// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gukhoe_app/screens/our_site_detailed_screen.dart';
import 'package:gukhoe_app/utils/get_constituency.dart';
import 'package:gukhoe_app/utils/show_alarm.dart';
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
  List<dynamic>? cityList;
  var textFieldText = '';
  // textfield controller
  final textController = TextEditingController();

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

// 내 위치로 찾기 버튼 클릭
  Future clickMyLocationButton() async {
    var geocode = await MapData.getGeocode(context);
    var location = await MapData.getReverseGeocode(geocode);
    String detailedLocation =
        "${location['area1']['name']} ${location['area2']['name']} ${location['area3']['name']}";
    setState(() {
      cityList = [detailedLocation];
    });
    (detailedLocation);
  }

  // 지역 검색 버튼 클릭
  Future clickSearchButton() async {
    if (textFieldText == "") {
      showAlarm(context, '', '검색어를 입력하세요');
    } else {
      try {
        var res = await MapData.getLocationInfo(textFieldText);
        List<String> locationList = [];
        for (var i = 0; i < res.length; i++) {
          locationList.add(res[i]['jibunAddress']);
        }
        setState(() {
          cityList = locationList;
        });
        print(locationList);
      } catch (e) {
        showAlarm(context, "에러", '지역이름을 바르게 입력하세요');
      }
    }
  }

  // 도시 리스트들 중 하나 클릭 function
  Future clickCityName(String name) async {
    final String answer = await getConstituency("육초코");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OurSiteDetailedScreen(name: answer),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.fromLTRB(15, 40, 10, 15),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: theme.page_title_box_height,
                child: Row(
                  children: const <Widget>[
                    Text(
                      '우리 지역 국회의원',
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

                  // 도시 검색 Text field
                  SizedBox(
                    height: 60,
                    child: TextField(
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: clickSearchButton,
                              icon: const Icon(
                                Icons.search,
                                size: 25,
                              )),
                          label: const Text('지역 입력'),
                          hintText: '지역을 입력하세요',
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: theme.main_color, width: 2))),
                      controller: textController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (text) {
                        clickSearchButton();
                      },
                      onChanged: (text) {
                        setState(() {
                          textFieldText = text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // 지역 리스트
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: cityList == null
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: cityList!
                                .map((cityName) => SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: InkWell(
                                        onTap: () {
                                          clickCityName(cityName);
                                        },
                                        borderRadius: BorderRadius.circular(10),
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
