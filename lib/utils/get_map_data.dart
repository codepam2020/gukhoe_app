import 'package:geolocator/geolocator.dart';
import 'package:gukhoe_app/utils/show_alarm.dart';
import 'package:http/http.dart' as http;
import '../data/private_data.dart';
import 'dart:convert';

class MapData {
  // 현재 위치 경도,위도 데이터 얻기
  static Future getGeocode(context) async {
    var enable = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (enable) {
      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission();
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return "${position.longitude},${position.latitude}";
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return "${position.longitude},${position.latitude}";
      }
    } else {
      showAlarm(context, 'GPS 오류', 'GPS 사용이 불가한 단말기입니다');
    }
  }

  // Geocode에 대한 주소 데이터 얻기
  static Future getReverseGeocode(String geocode) async {
    Uri uri = Uri.parse(
        'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$geocode&output=json');
    final response = await http.get(uri, headers: Private.naverHeader);

    final location = json.decode(response.body)['results'][0]['region'];
    // "${json.decode(response.body)['results'][0]['region']['area1']['name']} ${json.decode(response.body)['results'][0]['region']['area2']['name']} ${json.decode(response.body)['results'][0]['region']['area3']['name']}";

    return location;
  }

  // 지역이름 검색시 해당 주소 데이터 얻기
  static Future getLocationInfo(String cityName) async {
    Uri uri = Uri.parse(
        "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?count=100&query=$cityName");

    final response = await http.get(uri, headers: Private.naverHeader);

    var data = json.decode(response.body)['addresses'];

    return data;
  }
}
