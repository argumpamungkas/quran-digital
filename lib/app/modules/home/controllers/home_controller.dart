import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/base_url.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/bookmark.dart';

class HomeController extends GetxController {
  RxString nameUser = "".obs;

  final box = GetStorage();

  DatabaseManager dbManager = DatabaseManager.instance;

  Future<Map<String, dynamic>> getLastRead() async {
    Database db = await dbManager.db;
    List<Map<String, dynamic>> dataLastRead = await db.query(
      "bookmark",
      where: "last_read = 1",
    );
    if (dataLastRead.isEmpty) {
      return {};
    } else {
      return dataLastRead[0];
    }
  }

  Future<DataQuote> getQuote() async {
    Uri url = Uri.parse(BaseUrl.quote);
    var resp = await http.get(url);

    try {
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        Quote quote = Quote.fromJson(data);
        if (quote.data!.text!.isNotEmpty) {
          return quote.data as DataQuote;
        } else {
          throw Exception('Quote data is null');
        }
      } else {
        throw Exception('Failed to load Quote');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  void getNameUser() {
    if (box.read("userValid") != null) {
      nameUser.value = box.read("userValid");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNameUser();
    print("Dipanggil lagi");
  }
}
