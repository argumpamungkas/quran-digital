import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/base_url.dart';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/detail_surah.dart';

class DetailSurahController extends GetxController {
  Future<DataDetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse('${BaseUrl.quran}/surah/$id');
    var resp = await http.get(url);

    try {
      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        DetailSurah detailSurah = DetailSurah.fromJson(response);
        DataDetailSurah dataDetailSurah = detailSurah.data as DataDetailSurah;
        return dataDetailSurah;
      } else {
        Get.snackbar("Gagal Memuat", "Cek koneksi anda");
        throw Exception('Failed to load data');
      }
    } on SocketException {
      Get.snackbar("Gagal Memuat", "Cek koneksi anda");
      throw Exception('No Internet Connection');
    }
  }
}
