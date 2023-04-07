class TokenChangesDTO {
  final String priceChangePercent;
  final String lastPrice;

  TokenChangesDTO({
    required this.priceChangePercent,
    required this.lastPrice,
  });

  factory TokenChangesDTO.fromJson(Map<String, dynamic> json) => TokenChangesDTO(
        priceChangePercent: json["priceChangePercent"],
        lastPrice: json["lastPrice"],
      );

  Map<String, dynamic> toJson() => {
        "priceChangePercent": priceChangePercent,
        "lastPrice": lastPrice,
      };
}
