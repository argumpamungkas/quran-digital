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
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: Text(
            "Al - Qur'an",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.deepPurple.shade800),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade50,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.deepPurple.shade800,
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.BOOKMARK);
              },
              icon: const Icon(Icons.book),
              color: Colors.deepPurple.shade800,
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.deepPurple.shade800,
            indicatorColor: Colors.deepPurple.shade800,
            unselectedLabelColor: Colors.deepPurple.shade200,
            tabs: const [
              Tab(text: "Surat"),
              Tab(text: "Juz"),
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
                      title: Text(
                        "${dataSurah.name!.transliteration?.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "${dataSurah.numberOfVerses} Ayat | ${dataSurah.revelation?.id}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(
                        "${dataSurah.name!.short}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade800),
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
                  return Center(
                    child: Column(
                      children: [
                        const Text("Tidak ada data"),
                        ElevatedButton(
                            onPressed: () async {
                              await controller.getAllJuz();
                            },
                            child: const Text("Refresh"))
                      ],
                    ),
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
                        onTap: () async {
                          Get.dialog(
                            Dialog(
                              child: SizedBox(
                                height: 100,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Column(
                                    children: [
                                      const CircularProgressIndicator(),
                                      const SizedBox(height: 10),
                                      Center(
                                        child:
                                            Text("Loading Juz ${index + 1}..."),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          Future.delayed(
                            const Duration(seconds: 3),
                            () async {
                              Get.back();
                              return await Get.toNamed(
                                Routes.DETAIL_JUZ,
                                arguments: {
                                  "dataJuz": dataJuz,
                                  "dataSurah":
                                      allDataSurahWithJuz.reversed.toList(),
                                },
                              );
                            },
                          );
                        },
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
                              Center(
                                child: Text("${index + 1}"),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          "Juz ${dataJuz.juz}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "dari: ${dataJuz.juzStartInfo}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "sampai: ${dataJuz.juzEndInfo}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
