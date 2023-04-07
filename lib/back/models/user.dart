import 'package:trust_wallet_scm/back/models/trust_wallet.dart';

class User {
  final String login;
  final bool isModerator;
  final TrustWallet trustWallet;
  final bool hasPassword;

  User({
    required this.login,
    required this.isModerator,
    required this.trustWallet,
    required this.hasPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        isModerator: json["isModerator"],
        trustWallet: TrustWallet.fromJson(json["trustWallet"]),
        hasPassword: json["hasPassword"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "isModerator": isModerator,
        "trustWallet": trustWallet.toJson(),
        "hasPassword": hasPassword,
      };
}
