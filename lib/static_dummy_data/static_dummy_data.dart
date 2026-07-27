import 'dart:convert';

import 'package:flutter/services.dart';

class StaticDummyData {
  static const String _homeDataPath =
      'assets/static_dummy_data/home_dummy_data.json';
  static const String _workersDataPath =
      'assets/static_dummy_data/workers_dummy_data.json';

  static Future<Map> getHomeData() async {
    final String json = await rootBundle.loadString(_homeDataPath);
    final dynamic data = jsonDecode(json);
    return data is Map ? data : {};
  }

  static Future<Map> getWorkersData() async {
    final String json = await rootBundle.loadString(_workersDataPath);
    final dynamic data = jsonDecode(json);
    return data is Map ? data : {};
  }
}
