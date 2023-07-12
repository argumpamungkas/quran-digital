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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LinearProgressIndicator(
                        color: Colors.green,
                        backgroundColor: Colors.green.shade100,
                      ),
                    ),
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
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                    title:
                                        "Tafsir Ayat ${verse.number!.inSurah}",
                                    middleText: "${verse.tafsir?.id?.short}");
                              },
                              child: Container(
                                color: const Color.fromARGB(0, 255, 255, 255),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
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
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "${verse.translation!.id}",
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
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
