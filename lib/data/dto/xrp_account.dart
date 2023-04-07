class XRPAccount {
  final String xrpBalance;
  final String account;
  final String balance;
  final String index;
  final DateTime inception;
  final String txHash;

  XRPAccount({
    required this.xrpBalance,
    required this.account,
    required this.balance,
    required this.index,
    required this.inception,
    required this.txHash,
  });

  factory XRPAccount.fromJson(Map<String, dynamic> json) => XRPAccount(
        xrpBalance: json["xrpBalance"],
        account: json["Account"],
        balance: json["Balance"],
        index: json["index"],
        inception: DateTime.parse(json["inception"]),
        txHash: json["tx_hash"],
      );

  Map<String, dynamic> toJson() => {
        "xrpBalance": xrpBalance,
        "Account": account,
        "Balance": balance,
        "index": index,
        "inception": inception.toIso8601String(),
        "tx_hash": txHash,
      };
}
