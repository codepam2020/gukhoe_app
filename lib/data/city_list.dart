import 'dart:convert';
import 'package:flutter/services.dart';

class CityList {
  static Future getConstituency(area1, word) async {
    String? location;
    switch (area1) {
      case 'seoul':
        location = 'seoul';
        break;
      case 'gyeonggi':
        location = 'gyeonggi';
        break;
      case 'daegu':
        location = 'daegu';
    }
    try {
      String url = 'assets/${location}_gukhoe.json';
      final String res = await rootBundle.loadString(url);
      final data = await json.decode(res);
      final len = data.length;

      for (int i = 0; i < len; i++) {
        bool ans = data[i]['city_list'].toString().contains(word);
        if (ans) {
          return data[i]['constituency'];
        }
      }
    } catch (e) {
      print('Error in get constituency');
    }
  }
}
