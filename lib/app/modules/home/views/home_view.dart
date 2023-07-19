import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quran_app/app/constant/color.dart';
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
      body: Padding(
        padding: EdgeInsets.only(
          top: heightStatusBar - 10,
        ),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                "Assalamu'alakum",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                controller.nameUser.value.toUpperCase(),
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [
                    puprleLight,
                    puprleSolid,
                  ]),
                  boxShadow: const [
                    BoxShadow(
                      color: puprleLight,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
            ),
            const SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>>(
                future: controller.getLastRead(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: puprleSolid,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: puprleSolid,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            )
                          ]),
                    );
                  }

                  if (!snap.hasData || snap.data?['surah'] == null) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: puprleSolid,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: puprleSolid,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Belum ada bacaan terakhir",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }

                  Map<String, dynamic> dataLastRead = snap.data!;
                  return GestureDetector(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: puprleSolid,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: puprleSolid,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Terakhir\ndibaca",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Surat ${dataLastRead['surah']} ayat ${dataLastRead['ayat']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_circle_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.QURAN),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 120,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                quranLight,
                                quranSolid,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: quranSolid,
                                offset: Offset(0, 15),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Image.asset(
                                    "assets/images/quran.png",
                                    width: 50,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, bottom: 20),
                                  child: Text(
                                    "Al - Qur'an",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
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
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.DAILY_PRAYER),
                        child: Container(
                          height: 120,
                          width: Get.width,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                dailyPrayerLight,
                                dailyPrayerSolid,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: dailyPrayerSolid,
                                offset: Offset(0, 15),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Image.asset(
                                    "assets/images/daily-prayer.png",
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, bottom: 20),
                                  child: Text(
                                    "Doa Sehari - Hari",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18,
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
                ),

                // PEMISAH - ASMAUL HUNSA & BOOKMARK
                const SizedBox(width: 30),
                Flexible(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.ASMAUL_HUSNA),
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          height: 120,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                asmaulHusnaLight,
                                asmaulHusnaSolid,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: asmaulHusnaSolid,
                                offset: Offset(0, 15),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Image.asset(
                                    "assets/images/icon-asmaul-husna.png",
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, bottom: 20),
                                  child: Text(
                                    "Asmaul Husna",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.BOOKMARK),
                        child: Container(
                          height: 120,
                          width: Get.width,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                bookmarkLight,
                                bookmarkSolid,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: bookmarkSolid,
                                offset: Offset(0, 15),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Image.asset(
                                    "assets/images/bookmark.png",
                                    width: 50,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, bottom: 20),
                                  child: Text(
                                    "Bookmark",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
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
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
