import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/base_url.dart';
import 'package:quran_app/app/data/models/detail_surah.dart';
import 'package:quran_app/app/data/models/juz.dart';
import 'package:quran_app/app/data/models/surah.dart';

void main() async {
  for (var i = 1; i <= 114; i++) {
    var resp = await http.get(Uri.parse("${BaseUrl.quran}/surah/$i"));
    var response = jsonDecode(resp.body);

    DetailSurah detailSurah = DetailSurah.fromJson(response);

    print(detailSurah.data?.number);
  }
}
