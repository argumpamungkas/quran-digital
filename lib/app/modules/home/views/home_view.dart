import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

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
        child: GetBuilder<HomeController>(builder: (c) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Assalamu'alakum",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              child: Text(
                                controller.nameUser.value.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple.shade800,
                          side: BorderSide(
                              width: 1, color: Colors.deepPurple.shade800),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Ganti Nama",
                            titlePadding:
                                const EdgeInsets.only(top: 10, bottom: 5),
                            middleText:
                                " Apakah anda yakin akan mengganti nama? ",
                            middleTextStyle: const TextStyle(fontSize: 14),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await controller.changeName();
                                  Get.back();
                                  Get.dialog(
                                      barrierDismissible: false,
                                      Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircularProgressIndicator(
                                                color:
                                                    Colors.deepPurple.shade800,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    Get.offAllNamed(Routes.INTRODUCTION);
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.deepPurple,
                                ),
                                child: const Text("Ya"),
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
                        child: const Text(
                          "Ganti Nama",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: Get.width,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      puprleLight,
                      puprleSolid,
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: puprleLight,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Jadwal Solat Selanjutnya"),
                            TimeShalat(jamSolat: "11:45", waktuSolat: "Dhuhur"),
                            FittedBox(
                              child: Row(
                                children: [
                                  TimeShalat(
                                      jamSolat: "04:30", waktuSolat: "Shubuh"),
                                  const SizedBox(width: 20),
                                  TimeShalat(
                                      jamSolat: "11:45", waktuSolat: "Dhuhur"),
                                  const SizedBox(width: 20),
                                  TimeShalat(
                                      jamSolat: "15:15", waktuSolat: "Ashar"),
                                  const SizedBox(width: 20),
                                  TimeShalat(
                                      jamSolat: "17:50", waktuSolat: "Maghrib"),
                                  const SizedBox(width: 20),
                                  TimeShalat(
                                      jamSolat: "19:07", waktuSolat: "Isha"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // COMPASS KIBLAT
                      Flexible(
                        flex: 1,
                        child: FutureBuilder(
                          future: c.getPermission(),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.deepPurple,
                                  color: Colors.deepPurple.shade800,
                                ),
                              );
                            } else if (c.hasPermission) {
                              // STREAM BUILDER AFTER GET PERMISSION
                              return StreamBuilder(
                                stream: FlutterQiblah.qiblahStream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.deepPurple,
                                        color: Colors.deepPurple.shade800,
                                      ),
                                    );
                                  }

                                  final qiblahDirection = snapshot.data;
                                  c.animation = Tween(
                                    begin: c.begin,
                                    end: (qiblahDirection!.qiblah *
                                        (pi / 180) *
                                        -1),
                                  ).animate(c.animationController!);
                                  c.begin = (qiblahDirection.qiblah *
                                      (pi / 180) *
                                      -1);
                                  c.animationController!.forward(from: 0);

                                  return AnimatedBuilder(
                                    animation: c.animation!,
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: c.animation!.value,
                                        child: Image.asset(
                                          "assets/images/compass-qiblah.png",
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              return Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Kiblat\ntidak terdeteksi",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                    OutlinedButton(
                                        onPressed: () async {
                                          await c.getPermission();
                                        },
                                        style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.all(0),
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                width: 2, color: Colors.white)),
                                        child: const Text(
                                          "Sinkronisasi",
                                          style: TextStyle(fontSize: 8),
                                        )),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Map<String, dynamic>?>(
                future: c.getLastRead(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Terakhir\ndibaca",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Loading...",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.adjust,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snap.hasData || snap.data == null) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Terakhir\ndibaca",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Belum ada data",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.adjust,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  }

                  Map<String, dynamic> dataLastRead = snap.data!;
                  return GestureDetector(
                    onTap: () => Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                      "name":
                          dataLastRead['surah'].toString().replaceAll("+", "'"),
                      "number": dataLastRead['number_surah'],
                      "bookmark": dataLastRead,
                    }),
                    onLongPress: () => Get.defaultDialog(
                      title: "Hapus",
                      content: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                            "Apakah anda yakin akan menghapus bacaan terakhir ini?"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            c.deleteLastRead(dataLastRead['id']);
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
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
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
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                dataLastRead['surah']
                                    .toString()
                                    .replaceAll("+", "'"),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Juz ${dataLastRead['juz']} | Ayat ${dataLastRead['ayat']}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_circle_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
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
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
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
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
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
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
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
          );
        }),
      ),
    );
  }
}

class TimeShalat extends StatelessWidget {
  String jamSolat;
  String waktuSolat;

  TimeShalat({
    super.key,
    required this.jamSolat,
    required this.waktuSolat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(jamSolat),
        Text(waktuSolat),
      ],
    );
  }
}
