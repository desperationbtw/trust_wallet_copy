// To parse this JSON data, do
//
//     final transactionDto = transactionDtoFromJson(jsonString);

import 'dart:convert';

TransactionDto transactionDtoFromJson(String str) => TransactionDto.fromJson(json.decode(str));

String transactionDtoToJson(TransactionDto data) => json.encode(data.toJson());

class TransactionDto {
  TransactionDto({
    required this.transactions,
  });

  final List<Transaction> transactions;

  factory TransactionDto.fromJson(Map<String, dynamic> json) => TransactionDto(
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    required this.account,
    required this.amount,
    required this.destination,
    required this.date,
    required this.hash,
    required this.ledgerIndex,
  });

  final String account;
  final Amount amount;
  final String destination;
  final DateTime date;
  final String hash;
  final int ledgerIndex;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        account: json["Account"],
        amount: json["Amount"] == null ? Amount.fromJson(json["TakerGets"]) : Amount.fromJson(json["Amount"]),
        destination: json["Destination"] ?? 'XRPL',
        date: DateTime.parse(json["date"]),
        hash: json["hash"],
        ledgerIndex: json["ledger_index"],
      );

  Map<String, dynamic> toJson() => {
        "Account": account,
        "Amount": amount.toJson(),
        "Destination": destination,
        "date": date.toIso8601String(),
        "hash": hash,
        "ledger_index": ledgerIndex,
      };
}

class Amount {
  Amount({
    required this.value,
    required this.currency,
  });

  final int value;
  final String currency;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        value: json["value"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
      };
}
