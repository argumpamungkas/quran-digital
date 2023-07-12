import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/base_url.dart';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/daily_prayer.dart';

class DailyPrayerController extends GetxController {
  Future<List<DailyPrayer>> getAllDailyPrayer() async {
    Uri url = Uri.parse(BaseUrl.dailyPrayer);
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        if (data.isEmpty) {
          return [];
        } else {
          return data.map((e) => DailyPrayer.fromJson(e)).toList();
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }
}
