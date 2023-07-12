import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:quran_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 10 + heightStatusBar,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                "Assalamu'alakum",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                controller.nameUser.value.toUpperCase(),
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: Get.width,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFAAC8A7),
                  Color(0xFFC3EDC0),
                ]),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.QURAN),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Flexible(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "Al - Qur'an",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "assets/images/quran.png",
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.DAILY_PRAYER),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "assets/images/daily-prayer.png",
                                width: 70,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Flexible(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "Doa\nSehari Hari",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Daily Reminder",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: controller.getQuote(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: Get.width - 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        width: 5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: const Center(
                      child: Text("Loading..."),
                    ),
                  );
                }
                if (!snap.hasData) {
                  Container(
                    width: Get.width - 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        width: 5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: const Center(
                      child: Text("Tidak ada kata pengingat"),
                    ),
                  );
                }
                DataQuote? dataQuote = snap.data;
                return Container(
                  width: Get.width - 50,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 5,
                      color: Colors.blueGrey,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${dataQuote!.text}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "- ${dataQuote.reference} -",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
