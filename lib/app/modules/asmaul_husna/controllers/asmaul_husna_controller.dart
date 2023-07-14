import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../../data/models/asmaul_husna.dart';
import '../../../data/models/base_url.dart';
import 'package:http/http.dart' as http;

class AsmaulHusnaController extends GetxController {
  Future<List<DataAsmaulHusna>> getAsmaulHusna() async {
    Uri url = Uri.parse(BaseUrl.urlAsmaulHusna);
    var resp = await http.get(url);

    try {
      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        AsmaulHusna asmaulHusna = AsmaulHusna.fromJson(response);
        List<DataAsmaulHusna> dataAsmaulHusna =
            asmaulHusna.data as List<DataAsmaulHusna>;

        if (dataAsmaulHusna.isEmpty) {
          return [];
        } else {
          return dataAsmaulHusna;
        }
      } else {
        throw Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }
}
