import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/asmaul_husna.dart';
import 'package:quran_app/app/data/models/base_url.dart';
import 'package:quran_app/app/data/models/daily_prayer.dart';
import 'package:quran_app/app/data/models/detail_surah.dart';
import 'package:quran_app/app/data/models/juz.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:quran_app/app/data/models/surah.dart';

void main() async {
  List<DataJuz> dataJuz = [];
  for (var i = 1; i <= 2; i++) {
    Uri url = Uri.parse("${BaseUrl.quran}/juz/$i");
    var resp = await http.get(url);
    var response = jsonDecode(resp.body);
    Juz juz = Juz.fromJson(response);

    dataJuz.add(juz.data as DataJuz);
  }
  print(dataJuz[0].toJson());
}
