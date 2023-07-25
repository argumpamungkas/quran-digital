import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:quran_app/app/data/models/base_url.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../data/db/bookmark.dart';
import '../../../data/models/prayer_time.dart';

// ignore: deprecated_member_use
class HomeController extends GetxController with SingleGetTickerProviderMixin {
  RxString nameUser = "".obs;

  late TextEditingController nameC;

  final box = GetStorage();

  DatabaseManager dbManager = DatabaseManager.instance;

  final FlutterTts flutterTts = FlutterTts();

  bool hasPermission = false;

  String daerah = "";
  String kota = "";
  String? date;

  Animation<double>? animation;
  AnimationController? animationController;
  double begin = 0.0;

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await dbManager.db;
    List<Map<String, dynamic>> dataLastRead = await db.query(
      "bookmark",
      where: "last_read = 1",
    );
    if (dataLastRead.isEmpty) {
      return null;
    } else {
      return dataLastRead.first;
    }
  }

  Future deleteLastRead(int id) async {
    Database db = await dbManager.db;
    await db.delete("bookmark", where: "id = $id");
    update();
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
    if (box.read("nameUser") != null) {
      nameUser.value = box.read("nameUser");
      Future.delayed(const Duration(seconds: 1), () async {
        await flutterTts.setLanguage("en-US");
        await flutterTts.stop();
        await flutterTts.setSpeechRate(0.4);
        await flutterTts.speak("Assalamualaikum ${nameUser.value}");
      });
    }
  }

  Future<void> changeName() async {
    if (box.read("nameUser") != null) {
      await box.remove("nameUser");
    }
  }

  Future<void> getPermission() async {
    if (!hasPermission) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission locationPermission =
            await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => Get.defaultDialog(
              title: "Perhatian",
              content: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  "Lokasi tidak diberikan izin",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
          Future.delayed(const Duration(milliseconds: 2500), () => Get.back());
        } else {
          hasPermission = true;
          await getLocation();
        }
      } else {
        Get.defaultDialog(
            title: "Perhatian",
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                "Untuk mendapatkan jadwal solat dan arah kiblat, harap nyalakan GPS antum",
                textAlign: TextAlign.center,
              ),
            ));
        Future.delayed(const Duration(seconds: 5), () => Get.back());
      }
    }
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    daerah = placemarks.first.locality!;
    if (daerah.split(" ").first == "Kecamatan") {
      List<String> namaDaerah = daerah.split(" ");
      namaDaerah.removeWhere((element) => element.toLowerCase() == "kecamatan");
      daerah = namaDaerah.join(" ");
    }

    kota = placemarks.first.subAdministrativeArea!;
    if (kota.split(" ").first == "Kabupaten") {
      List<String> namaKota = kota.split(" ");
      namaKota.removeWhere((element) => element.toLowerCase() == "kabupaten");
      kota = namaKota.join(" ");
    }

    String dateFormat = DateTime.now().toString();
    date = dateFormat.split(" ").first;
    update(['permissionLocation']);
  }

  Future<DataJadwal> getPrayerTime() async {
    String id = "";
    Uri url = Uri.parse("https://api.banghasan.com/sholat/format/json/kota");
    var responseAllKota = await http.get(url);

    List allKota = jsonDecode(responseAllKota.body)['kota'];
    for (var element in allKota) {
      if (element['nama'] == kota.toUpperCase()) {
        id = element["id"];
      }
    }

    var responseJadwal = await http.get(Uri.parse(
        "https://api.banghasan.com/sholat/format/json/jadwal/kota/$id/tanggal/$date"));
    Map<String, dynamic> respJadwal = jsonDecode(responseJadwal.body)['jadwal']
        ['data'] as Map<String, dynamic>;
    DataJadwal dataJadwal = DataJadwal.fromJson(respJadwal);
    return dataJadwal;
  }

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);
    getNameUser();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController!);
  }

  @override
  void onClose() {
    super.onClose();
    animationController?.dispose();
  }
}
