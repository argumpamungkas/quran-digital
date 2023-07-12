import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/routes/app_pages.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Al-Qur'an",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                  height: 300,
                  width: 300,
                  child:
                      LottieBuilder.asset("assets/lotties/quran-lottie.json")),
              const Text(
                "Lewatilah hari-harimu denganku,",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Kupastikan akan ada keberkahan disetiap langkahmu.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  controller: controller.nameUserC,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1),
                    ),
                    hintText: "Masukkan Nama Antum",
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  controller.saveNameUser();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green[600],
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text("Mulai"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
