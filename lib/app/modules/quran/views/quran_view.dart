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
        ),
        body: FutureBuilder<List<DataSurah>>(
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
                    arguments: {
                      "name": dataSurah.name!.transliteration!.id,
                      "number": dataSurah.number,
                    },
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        const Image(
                          image: AssetImage("assets/images/octagon-list.png"),
                          color: Colors.deepPurple,
                        ),
                        Center(
                            child: Text(
                          "${dataSurah.number}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
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
      ),
    );
  }
}
