import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/asmaul_husna.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/asmaul_husna_controller.dart';

class AsmaulHusnaView extends GetView<AsmaulHusnaController> {
  const AsmaulHusnaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: const Text('Asmaul Husna'),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.deepPurple.shade50,
        ),
        body: FutureBuilder(
            future: controller.getAsmaulHusna(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 5 / 3,
                  ),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.deepPurple.shade100,
                      highlightColor: Colors.deepPurple.shade200,
                      child: Card(
                        color: Colors.deepPurple.shade200,
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
              return GridView.builder(
                itemCount: snap.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 5 / 3,
                ),
                itemBuilder: (context, index) {
                  DataAsmaulHusna dataAsmaulHusna = snap.data![index];
                  return GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "${dataAsmaulHusna.latin}",
                          middleText: "",
                          content: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${dataAsmaulHusna.arabic}",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${dataAsmaulHusna.idTranslation}",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ));
                    },
                    child: Card(
                      color: Colors.deepPurple.shade200,
                      child: Center(
                        child: Text(
                          "${dataAsmaulHusna.latin}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
