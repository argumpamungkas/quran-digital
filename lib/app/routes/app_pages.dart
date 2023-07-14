import 'package:get/get.dart';

import '../modules/asmaul_husna/bindings/asmaul_husna_binding.dart';
import '../modules/asmaul_husna/views/asmaul_husna_view.dart';
import '../modules/daily_prayer/bindings/daily_prayer_binding.dart';
import '../modules/daily_prayer/views/daily_prayer_view.dart';
import '../modules/detail_surah/bindings/detail_surah_binding.dart';
import '../modules/detail_surah/views/detail_surah_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/quran/bindings/quran_binding.dart';
import '../modules/quran/views/quran_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.QURAN,
      page: () => const QuranView(),
      binding: QuranBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH,
      page: () => DetailSurahView(),
      binding: DetailSurahBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DAILY_PRAYER,
      page: () => const DailyPrayerView(),
      binding: DailyPrayerBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ASMAUL_HUSNA,
      page: () => const AsmaulHusnaView(),
      binding: AsmaulHusnaBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
