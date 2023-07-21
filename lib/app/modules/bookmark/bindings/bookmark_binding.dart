import 'package:get/get.dart';
import 'package:quran_app/app/modules/quran/controllers/quran_controller.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkController>(
      () => BookmarkController(),
    );
    Get.lazyPut<QuranController>(
      () => QuranController(),
    );
  }
}
