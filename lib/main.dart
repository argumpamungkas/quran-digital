import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/app/constant/color.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      GetMaterialApp(
        theme: appLight,
        debugShowCheckedModeBanner: false,
        title: "Al-Qur'an Apps",
        initialRoute: Routes.SPLASH_SCREEN,
        getPages: AppPages.routes,
      ),
    ),
  );
}
