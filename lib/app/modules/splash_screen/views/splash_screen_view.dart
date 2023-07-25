import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Image.asset("assets/images/logo-quran.png"),
        ),
      ),
    );
  }
}
