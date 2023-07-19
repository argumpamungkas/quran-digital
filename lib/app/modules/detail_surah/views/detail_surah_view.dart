import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/constant/color.dart';
import 'package:quran_app/app/data/models/surah.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detail_surah_controller.dart';
import '../../../data/models/detail_surah.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  final DataSurah dataSurah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.BOOKMARK);
            },
            icon: const Icon(Icons.book),
            color: Colors.deepPurple.shade800,
          ),
        ],
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Get.defaultDialog(
                title: "TAFSIR",
                titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
                content: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      "${dataSurah.tafsir?.id}",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )),
            child: Card(
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
                        "${dataSurah.name!.transliteration!.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${dataSurah.name!.translation!.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Surat ke - ${dataSurah.number} | ${dataSurah.numberOfVerses} Ayat | ${dataSurah.revelation!.id}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
              future: controller.getDetailSurah(dataSurah.number.toString()),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator(
                    color: puprleLight,
                    backgroundColor: puprleSolid,
                  );
                }
                if (!snap.hasData) {
                  return const Center(
                    child: Text("Tidak ada data"),
                  );
                }
                return Column(
                  children: [
                    (snap.data?.preBismillah?.text?.arab == null)
                        ? const SizedBox(height: 10)
                        : Text(
                            "${snap.data?.preBismillah?.text?.arab}",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade800,
                            ),
                          ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dataSurah.numberOfVerses ?? 0,
                      itemBuilder: (context, index) {
                        Verse verse = snap.data!.verses![index];
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
                                  color: Colors.deepPurple.shade800
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
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
                                                "${verse.number!.inSurah}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GetBuilder<DetailSurahController>(
                                        builder: (c) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Get.defaultDialog(
                                                  title: "Bookmark",
                                                  middleText:
                                                      "Pilih Jenis Bookmark",
                                                  actions: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        controller.addBookmark(
                                                            true,
                                                            snap.data!,
                                                            verse,
                                                            index);
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                          color: Colors
                                                              .deepPurple
                                                              .shade800,
                                                        ),
                                                        foregroundColor: Colors
                                                            .deepPurple
                                                            .shade800,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        "Terakhir Dibaca",
                                                      ),
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        controller.addBookmark(
                                                            false,
                                                            snap.data!,
                                                            verse,
                                                            index);
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                          color: Colors
                                                              .deepPurple
                                                              .shade800,
                                                        ),
                                                        foregroundColor: Colors
                                                            .deepPurple
                                                            .shade800,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        "Bookmark",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.bookmark_add_outlined),
                                            ),

                                            // PLAY AUDIO
                                            (verse.conditionAudio == "stop")
                                                ? IconButton(
                                                    onPressed: () {
                                                      c.playAudio(verse);
                                                    },
                                                    icon: const Icon(
                                                      Icons.play_circle_outline,
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          c.stopAudio(verse);
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .stop_circle_outlined,
                                                        ),
                                                      ),
                                                      (verse.conditionAudio ==
                                                              "playing")
                                                          ? IconButton(
                                                              onPressed: () {
                                                                c.pauseAudio(
                                                                    verse);
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .pause_circle_outline,
                                                              ),
                                                            )
                                                          : IconButton(
                                                              onPressed: () {
                                                                c.resumeAudio(
                                                                    verse);
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .play_circle_outline,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title:
                                        "Tafsir Ayat ${verse.number!.inSurah}",
                                    content: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      constraints: const BoxConstraints(
                                        maxHeight: 300,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          "${verse.tafsir?.id?.short}",
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
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
                        );
                      },
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
