class AsmaulHusna {
  int? code;
  String? status;
  List<DataAsmaulHusna>? data;

  AsmaulHusna({
    this.code,
    this.status,
    this.data,
  });

  factory AsmaulHusna.fromJson(Map<String, dynamic>? json) => AsmaulHusna(
        code: json?["code"],
        status: json?["status"],
        data: json?["data"] == null
            ? null
            : List<DataAsmaulHusna>.from(
                json!["data"].map((x) => DataAsmaulHusna.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataAsmaulHusna {
  int? number;
  String? latin;
  String? arabic;
  String? idTranslation;
  String? enTranslation;

  DataAsmaulHusna({
    this.number,
    this.latin,
    this.arabic,
    this.idTranslation,
    this.enTranslation,
  });

  factory DataAsmaulHusna.fromJson(Map<String, dynamic>? json) =>
      DataAsmaulHusna(
        number: json?["number"],
        latin: json?["latin"],
        arabic: json?["arabic"],
        idTranslation: json?["id_translation"],
        enTranslation: json?["en_translation"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "latin": latin,
        "arabic": arabic,
        "id_translation": idTranslation,
        "en_translation": enTranslation,
      };
}
