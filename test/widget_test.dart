import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/daily_prayer.dart';
import 'package:quran_app/app/data/models/detail_surah.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:quran_app/app/data/models/surah.dart';

void main() async {
  Uri url = Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api");
  var response = await http.get(url);

  List resp = jsonDecode(response.body);

  DailyPrayer dailyPrayer = DailyPrayer.fromJson(resp[0]);

  print(dailyPrayer.toJson());
}
