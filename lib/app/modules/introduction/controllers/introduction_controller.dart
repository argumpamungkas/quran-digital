import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class IntroductionController extends GetxController {
  late TextEditingController nameUserC;

  final box = GetStorage();

  void saveNameUser() {
    if (nameUserC.text.isNotEmpty) {
      box.write("userValid", nameUserC.text);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Isi Nama Antum",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(0),
        borderRadius: 0,
        backgroundColor: Colors.red[800],
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
