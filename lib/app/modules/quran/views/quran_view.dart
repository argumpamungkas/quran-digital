import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/juz.dart' as juz;
import 'package:quran_app/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/surah.dart';
import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: const Text('ALL SURAH'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade50,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.deepPurple.shade800,
            indicatorColor: Colors.deepPurple.shade800,
            unselectedLabelColor: Colors.deepPurple.shade200,
            tabs: const [
              Tab(text: "Surat"),
              Tab(text: "Juz"),
              Tab(text: "Bookmark"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<DataSurah>>(
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
                      onTap: () => Get.toNamed(
                        Routes.DETAIL_SURAH,
                        arguments: dataSurah,
                      ),
                      leading: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            const Image(
                              image:
                                  AssetImage("assets/images/octagon-list.png"),
                              color: Colors.deepPurple,
                            ),
                            Center(child: Text("${dataSurah.number}")),
                          ],
                        ),
                      ),
                      title: Text("${dataSurah.name!.transliteration?.id}"),
                      subtitle: Text(
                        "${dataSurah.numberOfVerses} Ayat | ${dataSurah.revelation?.id}",
                      ),
                      trailing: Text(
                        "${dataSurah.name!.short}",
                        style: const TextStyle(fontSize: 22),
                      ),
                    );
                  },
                );
              },
            ),

            // JUZ
            FutureBuilder<List<juz.DataJuz>>(
                future: controller.getAllJuz(),
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
                      juz.DataJuz dataJuz = snap.data![index];

                      String? suratStart =
                          dataJuz.juzStartInfo?.split(" - ").first;
                      String? suratEnd = dataJuz.juzEndInfo?.split(" - ").first;

                      // Penampung dari for pertama
                      List<DataSurah> rawAllDataSurahWithJuz = [];

                      // Data asli/digunakan untuk passing data
                      List<DataSurah> allDataSurahWithJuz = [];

                      for (DataSurah element in controller.allDataSurah) {
                        rawAllDataSurahWithJuz.add(element);
                        if (element.name?.transliteration?.id == suratEnd) {
                          break;
                        }
                      }

                      for (var element
                          in rawAllDataSurahWithJuz.reversed.toList()) {
                        allDataSurahWithJuz.add(element);
                        if (element.name?.transliteration?.id == suratStart) {
                          break;
                        }
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          onTap: () => Get.toNamed(
                            Routes.DETAIL_JUZ,
                            arguments: {
                              "dataJuz": dataJuz,
                              "dataSurah":
                                  allDataSurahWithJuz.reversed.toList(),
                            },
                          ),
                          leading: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                const Image(
                                  image: AssetImage(
                                      "assets/images/octagon-list.png"),
                                  color: Colors.deepPurple,
                                ),
                                Center(child: Text("${index + 1}")),
                              ],
                            ),
                          ),
                          title: Text(
                            "Juz ${dataJuz.juz}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("dari: ${dataJuz.juzStartInfo}"),
                              Text("sampai: ${dataJuz.juzEndInfo}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
            const Text("3"),
          ],
        ),
      ),
    );
  }
}
