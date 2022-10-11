import 'package:geolocator/geolocator.dart';
import 'package:gukhoe_app/utils/show_alarm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapData {
  // 현재 위치 경도,위도 데이터 얻기
  static Future getGeocode(context) async {
    var enable = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (enable) {
      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission();
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return "${position.longitude},${position.latitude}";
      }
    } else {
      showAlarm(context, 'GPS 오류', 'GPS 사용이 불가한 단말기입니다');
    }
  }

  static Future getReverseGeocode(String geocode) async {
    Map<String, String> header = {
      "X-NCP-APIGW-API-KEY-ID": "n9bs1u3zhk",
      "X-NCP-APIGW-API-KEY": "kJviXEU5xFY133CkYr0xTz16GGeY7GWE1sR2pwjn"
    };
    Uri uri = Uri.parse(
        'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$geocode&output=json');
    final response = await http.get(uri, headers: header);

    String? location =
        "${json.decode(response.body)['results'][0]['region']['area1']['name']} ${json.decode(response.body)['results'][0]['region']['area2']['name']} ${json.decode(response.body)['results'][0]['region']['area3']['name']}";

    return location;
  }
}
