class Quote {
  int? code;
  String? status;
  DataQuote? data;

  Quote({
    this.code,
    this.status,
    this.data,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        code: json["code"],
        status: json["status"],
        data: DataQuote.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
      };
}

class DataQuote {
  String? text;
  String? reference;

  DataQuote({
    this.text,
    this.reference,
  });

  factory DataQuote.fromJson(Map<String, dynamic> json) => DataQuote(
        text: json["text"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "reference": reference,
      };
}
