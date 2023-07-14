import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/asmaul_husna.dart';
import 'package:quran_app/app/data/models/base_url.dart';
import 'package:quran_app/app/data/models/daily_prayer.dart';
import 'package:quran_app/app/data/models/detail_surah.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:quran_app/app/data/models/surah.dart';

void main() async {
  Uri url = Uri.parse(BaseUrl.urlAsmaulHusna);
  var resp = await http.get(url);

  var response = jsonDecode(resp.body);

  AsmaulHusna asmaulHusna = AsmaulHusna.fromJson(response);
  List<DataAsmaulHusna> dataAsmaulHusna =
      asmaulHusna.data as List<DataAsmaulHusna>;

  print(dataAsmaulHusna.toList());
}
