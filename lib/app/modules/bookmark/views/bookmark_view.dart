import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmark',
          style: TextStyle(
              color: Colors.deepPurple.shade800, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<BookmarkController>(builder: (c) {
        return FutureBuilder(
            future: controller.getAllBookmark(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snap.data?.length == 0) {
                return const Center(
                  child: Text("Belum ada data"),
                );
              }

              return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> dataBookmark = snap.data![index];
                  return ListTile(
                    onTap: () => Get.toNamed(
                      Routes.DETAIL_SURAH,
                      arguments: {
                        "name": dataBookmark['surah']
                            .toString()
                            .replaceAll("+", "'"),
                        "number": dataBookmark['number_surah'],
                        "bookmark": dataBookmark,
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
                              "${index + 1}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                        dataBookmark['surah'].toString().replaceAll("+", "'")),
                    subtitle: Text(
                        "Ayat ${dataBookmark['ayat']} | via ${dataBookmark['via']}"),
                    trailing: IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Hapus",
                          content: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "Apakah anda yakin akan menghapus ${dataBookmark['surah'].toString().replaceAll("+", "'")} Ayat ${dataBookmark['ayat']} dari bookmark?"),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                c.deleteBookmark(
                                    dataBookmark['id'],
                                    dataBookmark['surah']
                                        .toString()
                                        .replaceAll("+", "'"),
                                    dataBookmark['ayat']);
                                Get.back(closeOverlays: false);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Hapus"),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                              ),
                              child: const Text("Tidak"),
                            ),
                          ],
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              );
            });
      }),
    );
  }
}
