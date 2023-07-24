// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String status;
  Query query;
  Jadwal jadwal;

  Welcome({
    required this.status,
    required this.query,
    required this.jadwal,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        query: Query.fromJson(json["query"]),
        jadwal: Jadwal.fromJson(json["jadwal"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "query": query.toJson(),
        "jadwal": jadwal.toJson(),
      };
}

class Jadwal {
  String status;
  DataJadwal data;

  Jadwal({
    required this.status,
    required this.data,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        status: json["status"],
        data: DataJadwal.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class DataJadwal {
  String ashar;
  String dhuha;
  String dzuhur;
  String imsak;
  String isya;
  String maghrib;
  String subuh;
  String tanggal;
  String terbit;

  DataJadwal({
    required this.ashar,
    required this.dhuha,
    required this.dzuhur,
    required this.imsak,
    required this.isya,
    required this.maghrib,
    required this.subuh,
    required this.tanggal,
    required this.terbit,
  });

  factory DataJadwal.fromJson(Map<String, dynamic> json) => DataJadwal(
        ashar: json["ashar"],
        dhuha: json["dhuha"],
        dzuhur: json["dzuhur"],
        imsak: json["imsak"],
        isya: json["isya"],
        maghrib: json["maghrib"],
        subuh: json["subuh"],
        tanggal: json["tanggal"],
        terbit: json["terbit"],
      );

  Map<String, dynamic> toJson() => {
        "ashar": ashar,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "imsak": imsak,
        "isya": isya,
        "maghrib": maghrib,
        "subuh": subuh,
        "tanggal": tanggal,
        "terbit": terbit,
      };
}

class Query {
  String format;
  String kota;
  DateTime tanggal;

  Query({
    required this.format,
    required this.kota,
    required this.tanggal,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        format: json["format"],
        kota: json["kota"],
        tanggal: DateTime.parse(json["tanggal"]),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "kota": kota,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
      };
}
