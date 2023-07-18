import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/app/data/models/juz.dart';

class DetailJuzController extends GetxController {
  int indexNameSurah = 0;

  late final player = AudioPlayer();

  VerseJuz? lastVerseJuz;

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
