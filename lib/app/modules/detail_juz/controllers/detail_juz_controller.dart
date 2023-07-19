import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/app/data/models/juz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/bookmark.dart';

class DetailJuzController extends GetxController {
  int indexNameSurah = 0;

  late final player = AudioPlayer();

  VerseJuz? lastVerseJuz;

  DatabaseManager dbManager = DatabaseManager.instance;

  addBookmarkInJuz(
      bool lastRead, String nameSurah, VerseJuz verse, int indexAyat) async {
    Database db = await dbManager.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${nameSurah.replaceAll("'", "+")}' and ayat = ${verse.number!.inSurah} and juz = ${verse.meta!.juz} and via = 'juz' and index_ayat = $indexAyat and last_read = 0");
      if (checkData.isNotEmpty) {
        // jika ada data
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert(
        "bookmark",
        {
          "surah": nameSurah,
          "ayat": "${verse.number?.inSurah}",
          "juz": "${verse.meta?.juz}",
          "via": "juz",
          "index_ayat": indexAyat,
          "last_read": lastRead == true ? 1 : 0,
        },
      );

      Get.back();
      Get.snackbar(
        "Berhasil",
        lastRead == true
            ? "Berhasil menyimpan surat $nameSurah ayat ${verse.number!.inSurah} ke bacaan terakhir"
            : "Berhasil menambahkan surat $nameSurah ayat ${verse.number!.inSurah} ke dalam bookmark",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(0),
        borderRadius: 0,
      );
    } else {
      Get.back();
      Get.snackbar(
        "Data Sudah Ada",
        "Surat $nameSurah ayat ${verse.number!.inSurah} sudah ada di dalam bookmark",
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(0),
        borderRadius: 0,
      );
    }
  }

  void playAudio(VerseJuz verseJuz) async {
    if (verseJuz.audio?.primary != null) {
      try {
        lastVerseJuz ??= verseJuz;
        lastVerseJuz?.conditionAudio = "stop";
        lastVerseJuz = verseJuz;
        lastVerseJuz?.conditionAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(verseJuz.audio!.primary!);
        verseJuz.conditionAudio = "playing";
        update();
        await player.play();
        verseJuz.conditionAudio = "stop";
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

  void pauseAudio(VerseJuz versejuz) async {
    try {
      await player.pause();
      versejuz.conditionAudio = "pause";
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

  void resumeAudio(VerseJuz verseJuz) async {
    try {
      verseJuz.conditionAudio = "playing";
      update();
      await player.play();
      verseJuz.conditionAudio = "stop";
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

  void stopAudio(VerseJuz verseJuz) async {
    try {
      await player.stop();
      verseJuz.conditionAudio = "stop";
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
