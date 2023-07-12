import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/daily_prayer.dart';

import '../controllers/daily_prayer_controller.dart';

class DailyPrayerView extends GetView<DailyPrayerController> {
  const DailyPrayerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          title: const Text('Doa Sehari - Hari'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade200,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: controller.getAllDailyPrayer(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 4 / 2.5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.blueGrey.shade400,
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
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snap.data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 2.5,
                ),
                itemBuilder: (context, index) {
                  DailyPrayer dailyPrayer = snap.data![index];
                  return GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: "${dailyPrayer.doa}",
                        middleText: "",
                        content: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                "${dailyPrayer.ayat}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${dailyPrayer.latin}",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 15),
                              Text("${dailyPrayer.artinya}"),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.blueGrey.shade400,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            "${dailyPrayer.doa}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
