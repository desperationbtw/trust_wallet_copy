import 'package:trust_wallet_scm/domain/enum/transaction_status.dart';
export 'package:trust_wallet_scm/domain/enum/transaction_status.dart';

/// Транзакция
class TransactionUI {
  /// Статус транзакции
  final TransactionStatus status;

  /// Дата транзакции
  final DateTime date;

  /// Кол-во монеты в транзакции
  final double count;

  /// С кем произведен обмен
  final String partner;

  /// Комиссия сетевого сбора
  final double comission;

  final String hash;

  /// ХЗ :D
  final List<dynamic> accepts;

  const TransactionUI({
    required this.status,
    required this.date,
    required this.count,
    required this.partner,
    required this.comission,
    required this.hash,
    this.accepts = const [],
  });
}
