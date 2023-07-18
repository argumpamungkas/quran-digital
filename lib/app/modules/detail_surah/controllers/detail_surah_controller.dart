import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/app/data/models/base_url.dart';

import 'package:http/http.dart' as http;
import 'package:quran_app/app/data/models/detail_surah.dart';

class DetailSurahController extends GetxController {
  late final player = AudioPlayer();

  Verse? lastVerse;

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

  void playAudio(Verse verse) async {
    if (verse.audio?.primary != null) {
      try {
        lastVerse ??= verse;
        lastVerse?.conditionAudio = "stop";
        lastVerse = verse;
        lastVerse?.conditionAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(verse.audio!.primary!);
        verse.conditionAudio = "playing";
        update();
        await player.play();
        verse.conditionAudio = "stop";
        update();
        await player.stop();
      } on PlayerException catch (e) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Error message: ${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          margin: const EdgeInsets.all(0),
        );
      } on PlayerInterruptedException catch (e) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Connection Aborted: ${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          margin: const EdgeInsets.all(0),
        );
      } catch (e) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat putar audio",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          margin: const EdgeInsets.all(0),
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Audio gagal diputar",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    }
  }

  void pauseAudio(Verse verse) async {
    try {
      await player.pause();
      verse.conditionAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Error message: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    } on PlayerInterruptedException catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Connection Aborted: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak dapat pause audio",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    }
  }

  void resumeAudio(Verse verse) async {
    try {
      verse.conditionAudio = "playing";
      update();
      await player.play();
      verse.conditionAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Error message: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    } on PlayerInterruptedException catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Connection Aborted: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak dapat melanjutkan audio",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    }
  }

  void stopAudio(Verse verse) async {
    try {
      await player.stop();
      verse.conditionAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Error message: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    } on PlayerInterruptedException catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Connection Aborted: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak dapat menghentikan audio",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        margin: const EdgeInsets.all(0),
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    player.dispose();
  }
}
