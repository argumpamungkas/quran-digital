class Juz {
  int? code;
  String? status;
  String? message;
  DataJuz? data;

  Juz({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory Juz.fromJson(Map<String, dynamic>? json) => Juz(
        code: json?["code"],
        status: json?["status"],
        message: json?["message"],
        data: DataJuz.fromJson(json?["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataJuz {
  int? juz;
  int? juzStartSurahNumber;
  int? juzEndSurahNumber;
  String? juzStartInfo;
  String? juzEndInfo;
  int? totalVerses;
  List<VerseJuz>? verses;

  DataJuz({
    this.juz,
    this.juzStartSurahNumber,
    this.juzEndSurahNumber,
    this.juzStartInfo,
    this.juzEndInfo,
    this.totalVerses,
    this.verses,
  });

  factory DataJuz.fromJson(Map<String, dynamic>? json) => DataJuz(
        juz: json?["juz"],
        juzStartSurahNumber: json?["juzStartSurahNumber"],
        juzEndSurahNumber: (json?["juzEndSurahNumber"].runtimeType == String)
            ? int.parse(json?["juzEndSurahNumber"])
            : json?["juzEndSurahNumber"],
        juzStartInfo: json?["juzStartInfo"],
        juzEndInfo: json?["juzEndInfo"],
        totalVerses: json?["totalVerses"],
        verses: (json?["verses"] == null)
            ? null
            : List<VerseJuz>.from(
                json?["verses"].map((x) => VerseJuz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "juzStartSurahNumber": juzStartSurahNumber,
        "juzEndSurahNumber": juzEndSurahNumber,
        "juzStartInfo": juzStartInfo,
        "juzEndInfo": juzEndInfo,
        "totalVerses": totalVerses,
        "verses": verses == null
            ? null
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
      };
}

class VerseJuz {
  Number? number;
  Meta? meta;
  Text? text;
  Translation? translation;
  Audio? audio;
  Tafsir? tafsir;

  VerseJuz({
    this.number,
    this.meta,
    this.text,
    this.translation,
    this.audio,
    this.tafsir,
  });

  factory VerseJuz.fromJson(Map<String, dynamic>? json) => VerseJuz(
        number: Number.fromJson(json?["number"]),
        meta: Meta.fromJson(json?["meta"]),
        text: Text.fromJson(json?["text"]),
        translation: Translation.fromJson(json?["translation"]),
        audio: Audio.fromJson(json?["audio"]),
        tafsir: Tafsir.fromJson(json?["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number?.toJson(),
        "meta": meta?.toJson(),
        "text": text?.toJson(),
        "translation": translation?.toJson(),
        "audio": audio?.toJson(),
        "tafsir": tafsir?.toJson(),
      };
}

class Audio {
  String? primary;
  List<String>? secondary;

  Audio({
    this.primary,
    this.secondary,
  });

  factory Audio.fromJson(Map<String, dynamic>? json) => Audio(
        primary: json?["primary"],
        secondary: json?["secondary"] == null
            ? null
            : List<String>.from(json?["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary == null
            ? null
            : List<dynamic>.from(secondary!.map((x) => x)),
      };
}

class Meta {
  int? juz;
  int? page;
  int? manzil;
  int? ruku;
  int? hizbQuarter;
  Sajda? sajda;

  Meta({
    this.juz,
    this.page,
    this.manzil,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
        juz: json?["juz"],
        page: json?["page"],
        manzil: json?["manzil"],
        ruku: json?["ruku"],
        hizbQuarter: json?["hizbQuarter"],
        sajda: Sajda.fromJson(json?["sajda"]),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda?.toJson(),
      };
}

class Sajda {
  bool? recommended;
  bool? obligatory;

  Sajda({
    this.recommended,
    this.obligatory,
  });

  factory Sajda.fromJson(Map<String, dynamic>? json) => Sajda(
        recommended: json?["recommended"],
        obligatory: json?["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Number {
  int? inQuran;
  int? inSurah;

  Number({
    this.inQuran,
    this.inSurah,
  });

  factory Number.fromJson(Map<String, dynamic>? json) => Number(
        inQuran: json?["inQuran"],
        inSurah: json?["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Tafsir {
  Id? id;

  Tafsir({
    this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic>? json) => Tafsir(
        id: Id.fromJson(json?["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
      };
}

class Id {
  String? short;
  String? long;

  Id({
    this.short,
    this.long,
  });

  factory Id.fromJson(Map<String, dynamic>? json) => Id(
        short: json?["short"],
        long: json?["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}

class Text {
  String? arab;
  Transliteration? transliteration;

  Text({
    this.arab,
    this.transliteration,
  });

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: Transliteration.fromJson(json["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration?.toJson(),
      };
}

class Transliteration {
  String? en;

  Transliteration({
    this.en,
  });

  factory Transliteration.fromJson(Map<String, dynamic>? json) =>
      Transliteration(
        en: json?["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
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
