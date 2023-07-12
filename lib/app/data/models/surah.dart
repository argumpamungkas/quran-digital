class Surah {
  int? code;
  String? status;
  String? message;
  List<DataSurah>? data;

  Surah({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory Surah.fromJson(Map<String, dynamic>? json) => Surah(
        code: json?["code"],
        status: json?["status"],
        message: json?["message"],
        data: (json?["data"] == null)
            ? null
            : List<DataSurah>.from(
                json!["data"].map((x) => DataSurah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataSurah {
  int? number;
  int? sequence;
  int? numberOfVerses;
  Name? name;
  Revelation? revelation;
  Tafsir? tafsir;

  DataSurah({
    this.number,
    this.sequence,
    this.numberOfVerses,
    this.name,
    this.revelation,
    this.tafsir,
  });

  factory DataSurah.fromJson(Map<String, dynamic>? json) => DataSurah(
        number: json?["number"],
        sequence: json?["sequence"],
        numberOfVerses: json?["numberOfVerses"],
        name: Name.fromJson(json?["name"]),
        revelation: Revelation.fromJson(json?["revelation"]),
        tafsir: Tafsir.fromJson(json?["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name?.toJson(),
        "revelation": revelation?.toJson(),
        "tafsir": tafsir?.toJson(),
      };
}

class Name {
  String? short;
  String? long;
  Translation? transliteration;
  Translation? translation;

  Name({
    this.short,
    this.long,
    this.transliteration,
    this.translation,
  });

  factory Name.fromJson(Map<String, dynamic>? json) => Name(
        short: json?["short"],
        long: json?["long"],
        transliteration: Translation.fromJson(json?["transliteration"]),
        translation: Translation.fromJson(json?["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration?.toJson(),
        "translation": translation?.toJson(),
      };
}

class Translation {
  String? en;
  String? id;

  Translation({
    this.en,
    this.id,
  });

  factory Translation.fromJson(Map<String, dynamic>? json) => Translation(
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}

class Revelation {
  String? arab;
  String? en;
  String? id;

  Revelation({
    this.arab,
    this.en,
    this.id,
  });

  factory Revelation.fromJson(Map<String, dynamic>? json) => Revelation(
        arab: json?["arab"],
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
      };
}

class Tafsir {
  String? id;

  Tafsir({
    this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic>? json) => Tafsir(
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
