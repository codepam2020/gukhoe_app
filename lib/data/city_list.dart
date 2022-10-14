import 'dart:convert';
import 'package:flutter/services.dart';

class CityList {
  static Future<dynamic> readJson() async {
    final String res = await rootBundle.loadString('assets/seoul_gukhoe.json');
    final data = json.decode(res);
    return data;
  }
}
