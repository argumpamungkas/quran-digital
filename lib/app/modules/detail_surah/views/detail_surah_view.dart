import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/constant/color.dart';
import 'package:quran_app/app/modules/home/controllers/home_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detail_surah_controller.dart';
import '../../../data/models/detail_surah.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);

  final homeC = Get.find<HomeController>();

  Map<String, dynamic>? dataBookmark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          Get.arguments["name"].toString().toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade800,
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
      body: FutureBuilder(
        future: controller.getDetailSurah(Get.arguments["number"].toString()),
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

          if (Get.arguments["bookmark"] != null) {
            dataBookmark = Get.arguments["bookmark"];
            if (dataBookmark!["index_ayat"] > 0) {
              controller.scrollC.scrollToIndex(
                dataBookmark!["index_ayat"] + 2,
                preferPosition: AutoScrollPosition.begin,
              );
            }
          }

          DataDetailSurah dataSurah = snap.data!;

          List<Widget> allVerse = List.generate(
            dataSurah.verses!.length,
            (index) {
              Verse verse = dataSurah.verses![index];
              return AutoScrollTag(
                key: ValueKey(index + 2),
                controller: controller.scrollC,
                index: index + 2,
                child: Container(
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
                                          middleText: "Pilih Jenis Bookmark",
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () async {
                                                await c.addBookmark(true,
                                                    snap.data!, verse, index);
                                                homeC.update();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color: Colors
                                                      .deepPurple.shade800,
                                                ),
                                                foregroundColor:
                                                    Colors.deepPurple.shade800,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                "Terakhir Dibaca",
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () async {
                                                await c.addBookmark(false,
                                                    snap.data!, verse, index);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color: Colors
                                                      .deepPurple.shade800,
                                                ),
                                                foregroundColor:
                                                    Colors.deepPurple.shade800,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                                  Icons.stop_circle_outlined,
                                                ),
                                              ),
                                              (verse.conditionAudio ==
                                                      "playing")
                                                  ? IconButton(
                                                      onPressed: () {
                                                        c.pauseAudio(verse);
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .pause_circle_outline,
                                                      ),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        c.resumeAudio(verse);
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
                            title: "Tafsir Ayat ${verse.number!.inSurah}",
                            content: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                ),
              );
            },
          );

          return ListView(
            controller: controller.scrollC,
            children: [
              AutoScrollTag(
                key: const ValueKey(0),
                controller: controller.scrollC,
                index: 0,
                child: GestureDetector(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: Column(
                          children: [
                            Text(
                              dataSurah.name!.transliteration!.id
                                  .toString()
                                  .toUpperCase(),
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
              ),
              const SizedBox(height: 10),
              AutoScrollTag(
                key: const ValueKey(1),
                controller: controller.scrollC,
                index: 1,
                child: (dataSurah.preBismillah?.text?.arab == null)
                    ? const SizedBox(height: 10)
                    : Center(
                        child: Text(
                          "${dataSurah.preBismillah?.text?.arab}",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade800,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              ...allVerse,
            ],
          );
        },
      ),
    );
  }
}
