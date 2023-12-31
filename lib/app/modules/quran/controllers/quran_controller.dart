import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/base_url.dart';

import '../../../data/models/surah.dart';

class QuranController extends GetxController {
  List<DataSurah> allDataSurah = [];

  Future<List<DataSurah>> getAllSurah() async {
    Uri url = Uri.parse("${BaseUrl.quran}/surah");
    var resp = await http.get(url);

    try {
      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        Surah surah = Surah.fromJson(response);
        allDataSurah = surah.data as List<DataSurah>;
        if (allDataSurah.isEmpty) {
          return [];
        } else {
          return allDataSurah;
        }
      } else {
        throw Exception('Failed to Load All Surah');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }
}
