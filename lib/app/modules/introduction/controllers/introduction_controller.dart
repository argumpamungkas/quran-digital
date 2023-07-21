import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class IntroductionController extends GetxController {
  late TextEditingController nameUserC;

  final box = GetStorage();

  void saveNameUser() {
    if (nameUserC.text.isNotEmpty) {
      box.write("nameUser", nameUserC.text);
      Get.dialog(
          barrierDismissible: false,
          Dialog(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.deepPurple.shade800,
                  ),
                ],
              ),
            ),
          ));
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.HOME);
      });
    } else {
      Get.snackbar(
        "Gagal Masuk",
        "Harap masukkan nama antum",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(0),
        borderRadius: 0,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameUserC = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    nameUserC.dispose();
  }
}
