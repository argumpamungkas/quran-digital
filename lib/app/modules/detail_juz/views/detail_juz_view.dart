import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/juz.dart' as juz;

import '../../../constant/color.dart';
import '../../../data/models/surah.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  DetailJuzView({Key? key}) : super(key: key);

  juz.DataJuz dataJuz = Get.arguments["dataJuz"];
  List<DataSurah> dataSurahInJuz = Get.arguments["dataSurah"];

  @override
  Widget build(BuildContext context) {
    dataSurahInJuz.forEach(
      (element) {
        print(element.name?.transliteration?.id);
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    puprleLight,
                    puprleSolid,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: puprleSolid,
                    offset: Offset(0, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: [
                    Text(
                      "Juz ${dataJuz.juz}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "dari: ${dataJuz.juzStartInfo}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "sampai: ${dataJuz.juzEndInfo} ",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataJuz.verses!.length,
            itemBuilder: (context, index) {
              juz.VerseJuz verseJuz = dataJuz.verses![index];

              if (index != 0) {
                if (verseJuz.number?.inSurah == 1) {
                  controller.indexNameSurah++;
                }
              }
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade800.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 35,
                                  width: 35,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        "assets/images/octagon-list.png",
                                        color: Colors.deepPurple.shade800,
                                      ),
                                      Center(
                                        child: Text(
                                          "${verseJuz.number!.inSurah}",
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${dataSurahInJuz[controller.indexNameSurah].name?.transliteration?.id}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print("bookmark");
                                  },
                                  icon: const Icon(Icons.bookmark_add_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print("play");
                                  },
                                  icon: const Icon(Icons.play_circle),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: "Tafsir",
                          middleText: "",
                          content: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            constraints: const BoxConstraints(
                              maxHeight: 300,
                            ),
                            child: SingleChildScrollView(
                              child: Text("${verseJuz.tafsir!.id!.short}"),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${verseJuz.text!.arab}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${verseJuz.text!.transliteration!.en}",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "${verseJuz.translation!.id}",
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
              );
            },
          ),
        ],
      ),
    );
  }
}
