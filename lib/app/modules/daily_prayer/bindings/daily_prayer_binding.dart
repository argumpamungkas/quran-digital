import 'package:get/get.dart';

import '../controllers/daily_prayer_controller.dart';

class DailyPrayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyPrayerController>(
      () => DailyPrayerController(),
    );
  }
}
