import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/prayer_time.dart';

void main() async {
  String dateFormat = DateTime.now().toString();
  String date = dateFormat.split(" ").first;
  Uri url = Uri.parse("https://api.banghasan.com/sholat/format/json/kota");
  var responseAllKota = await http.get(url);
  List kota = jsonDecode(responseAllKota.body)['kota'];
  String id = "";
  for (var element in kota) {
    if (element['nama'] == "SUMEDANG") {
      id = element["id"];
    }
  }

  var responseJadwal = await http.get(Uri.parse(
      "https://api.banghasan.com/sholat/format/json/jadwal/kota/$id/tanggal/$date"));
  Map<String, dynamic> respJadwal = (jsonDecode(responseJadwal.body)['jadwal']
      ['data']) as Map<String, dynamic>;
  DataJadwal dataJadwal = DataJadwal.fromJson(respJadwal);
  print(dataJadwal.subuh);
  print(dataJadwal.dzuhur);
  print(dataJadwal.ashar);
  print(dataJadwal.maghrib);
  print(dataJadwal.isya);
}
