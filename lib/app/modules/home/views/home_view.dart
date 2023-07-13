import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/data/models/quotes.dart';
import 'package:quran_app/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightStatusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: EdgeInsets.only(
          top: heightStatusBar - 10,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: ListView(
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
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [
                    Color(0xffA7D7C5),
                    Color(0xFFC3EDC0),
                  ]),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffA7D7C5),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.QURAN),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffC0DEFF),
                            Color(0xff82AAE3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff82AAE3),
                            offset: Offset(0, 15),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/images/quran.png",
                              width: 70,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              "Al - Qur'an",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Flexible(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.QURAN),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffBFDCE5),
                            Color(0xff6096B4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff6096B4),
                            offset: Offset(0, 15),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(30, 200, 200, 200),
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/images/daily-prayer.png",
                              width: 70,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              "Doa Sehari - Hari",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              "✨ Daily Reminder ✨",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: controller.getQuote(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: const Color(0xffFFFAD7),
                    highlightColor: const Color(0xffFFE4A7),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: Get.width,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 10, color: Colors.yellow.shade300),
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                if (!snap.hasData) {
                  Container(
                    width: Get.width - 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(width: 2, color: Colors.yellow.shade300),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffFFFAD7),
                          Color(0xffFFE4A7),
                        ],
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
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.yellow.shade300),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFFFAD7),
                        Color(0xffFFE4A7),
                      ],
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
