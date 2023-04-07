class TrustWallet {
  final String address;
  final int walletCash;

  TrustWallet({
    required this.address,
    required this.walletCash,
  });

  factory TrustWallet.fromJson(Map<String, dynamic> json) => TrustWallet(
        address: json["address"],
        walletCash: json["walletCash"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "walletCash": walletCash,
      };
}
