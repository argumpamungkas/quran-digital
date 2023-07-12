import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();

  void validateUser() {
    if (box.read('userValid') == null) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAllNamed(Routes.INTRODUCTION),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAllNamed(Routes.HOME),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    validateUser();
  }
}
