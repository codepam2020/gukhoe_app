import 'dart:convert';
import 'package:flutter/services.dart';

Future getConstituency(String location) async {
  switch (location) {
    case "육초코":
      {
        String constituency;
        String cityList;
        String answer = "Recheck Your City Name";

        final res = await rootBundle.loadString('assets/gyeonggi_gukhoe.json');
        final data = json.decode(res);
        for (var i = 0; i < data.length; i++) {
          constituency = data[i]['constituency'];
          cityList = data[i]['city_list'].toString();
          if (cityList.contains("영통")) {
            answer = constituency;
          }
        }
        return answer;
      }
      break;
    default:
      {
        return "Error";
      }
      break;
  }
}
