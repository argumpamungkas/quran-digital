class DailyPrayer {
  String? id;
  String? doa;
  String? ayat;
  String? latin;
  String? artinya;

  DailyPrayer({
    this.id,
    this.doa,
    this.ayat,
    this.latin,
    this.artinya,
  });

  factory DailyPrayer.fromJson(Map<String, dynamic>? json) => DailyPrayer(
        id: json?["id"],
        doa: json?["doa"],
        ayat: json?["ayat"],
        latin: json?["latin"],
        artinya: json?["artinya"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doa": doa,
        "ayat": ayat,
        "latin": latin,
        "artinya": artinya,
      };
}
