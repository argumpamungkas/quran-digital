import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

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
            return ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade400,
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 20,
                      width: 80,
                      color: Colors.grey,
                    ),
                    subtitle: Container(
                      height: 20,
                      width: 100,
                      color: Colors.grey,
                    ),
                    trailing: Container(
                      height: 30,
                      width: 80,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
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
