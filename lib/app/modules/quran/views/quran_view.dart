import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/routes/app_pages.dart';

import '../../../data/models/surah.dart';
import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL SURAH'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: FutureBuilder(
        future: controller.getAllSurah(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snap.hasData) {
            return const Center(
              child: Text("Tidak ada data"),
            );
          }
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              DataSurah dataSurah = snap.data![index];
              return ListTile(
                onLongPress: () {
                  Get.defaultDialog(
                    title: "TAFSIR",
                    middleText: "${dataSurah.tafsir?.id}",
                    titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
                  );
                },
                onTap: () => Get.toNamed(
                  Routes.DETAIL_SURAH,
                  arguments: dataSurah,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green[300],
                  foregroundColor: Colors.white,
                  child: Text("${dataSurah.number}"),
                ),
                title: Text("${dataSurah.name!.transliteration?.id}"),
                subtitle: Text(
                    "${dataSurah.numberOfVerses} Ayat | ${dataSurah.revelation?.id}"),
                trailing: Text(
                  "${dataSurah.name!.short}",
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
