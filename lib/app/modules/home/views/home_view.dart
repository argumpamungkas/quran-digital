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
      backgroundColor: Colors.deepPurple[50],
      body: Padding(
        padding: EdgeInsets.only(
          top: heightStatusBar - 10,
          bottom: 5,
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
                    Color(0xffD7BBF5),
                    Color(0xFF9681EB),
                  ]),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffD7BBF5),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffECC9EE),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffC4B0FF),
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    )
                  ]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Al-Ikhlas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Icon(Icons.arrow_circle_right),
                ],
              ),
            ),
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
                                Color(0xffB7C4CF),
                                Color(0xff7895B2),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff7895B2),
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
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffDEB6AB),
                                Color(0xff85586F),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff85586F),
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
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffE5BEEC),
                                Color(0xff917FB3),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff917FB3),
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
                        onTap: () => Get.toNamed(Routes.DAILY_PRAYER),
                        child: Container(
                          height: 120,
                          width: Get.width,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffA8A4CE),
                                Color(0xff495C83),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff2B4865),
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
