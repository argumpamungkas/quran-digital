import 'package:get/get.dart';
import 'package:quran_app/app/data/db/bookmark.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkController extends GetxController {
  DatabaseManager dbManager = DatabaseManager.instance;
  RxBool allDataViaJuz = false.obs;

  Future<List<Map<String, dynamic>>> getAllBookmark() async {
    Database db = await dbManager.db;
    List<Map<String, dynamic>> allDataBookmark = await db.query(
      "bookmark",
      where: "last_read = 0",
      orderBy: "juz, surah, ayat",
    );
    if (allDataBookmark.isEmpty) {
      return [];
    } else {
      return allDataBookmark;
    }
  }

  Future deleteBookmark(int id, String nameSurah, int ayat) async {
    Database db = await dbManager.db;
    await db.delete("bookmark", where: "id = $id");
    update();
    Get.back();
  }
}
