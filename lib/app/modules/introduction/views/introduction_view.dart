import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Al-Qur'an",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(
                  height: 300,
                  width: 300,
                  child:
                      LottieBuilder.asset("assets/lotties/quran-lottie.json")),
              const Text(
                "Lewatilah hari-harimu denganku,",
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Kupastikan akan ada keberkahan disetiap langkahmu.",
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  controller: controller.nameUserC,
                  autocorrect: false,
                  cursorColor: Colors.green,
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
                    hintStyle: const TextStyle(color: Colors.grey),
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
