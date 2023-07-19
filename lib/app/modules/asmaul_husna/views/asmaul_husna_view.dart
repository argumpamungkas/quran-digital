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
        appBar: AppBar(
          title: const Text('Asmaul Husna'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getAsmaulHusna(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  itemCount: 8,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2, color: Colors.deepPurple.shade200),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 3),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              color: Colors.deepPurple.shade200,
                            ),
                            child: Center(
                              child: Text(
                                "${dataAsmaulHusna.latin}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "${dataAsmaulHusna.arabic}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "${dataAsmaulHusna.idTranslation}",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
