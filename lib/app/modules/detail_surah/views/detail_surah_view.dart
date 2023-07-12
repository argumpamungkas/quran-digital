import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/surah.dart';

import '../controllers/detail_surah_controller.dart';
import '../../../data/models/detail_surah.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  final DataSurah dataSurah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
            alignment: Alignment.topLeft,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "${dataSurah.name!.transliteration!.id}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Text(
                    "${dataSurah.name!.translation!.id}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Surat ke - ${dataSurah.number} | ${dataSurah.numberOfVerses} Ayat | ${dataSurah.revelation!.id}",
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
              future: controller.getDetailSurah(dataSurah.number.toString()),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }
                if (!snap.hasData) {
                  return const Center(
                    child: Text("Tidak ada data"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataSurah.numberOfVerses ?? 0,
                  itemBuilder: (context, index) {
                    Verse verse = snap.data!.verses![index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${verse.number!.inSurah}"),
                                const Row(
                                  children: [
                                    Icon(Icons.bookmark_add_outlined),
                                    Icon(Icons.play_arrow),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${verse.text!.arab}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${verse.text!.transliteration!.en}",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "${verse.translation!.id}",
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
