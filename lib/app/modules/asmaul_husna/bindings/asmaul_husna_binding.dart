import 'package:get/get.dart';

import '../controllers/asmaul_husna_controller.dart';

class AsmaulHusnaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AsmaulHusnaController>(
      () => AsmaulHusnaController(),
    );
  }
}
