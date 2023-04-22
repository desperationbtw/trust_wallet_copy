import 'package:trust_wallet_scm/domain/enum/token_type.dart';
export 'package:trust_wallet_scm/domain/enum/token_type.dart';

class Token {
  final TokenType type;
  final double? price;
  final double? percent;
  final double count;

  double? get fiatCount => price == null ? null : count * price!;

  const Token({
    required this.type,
    this.price,
    this.percent,
    required this.count,
  });
}
