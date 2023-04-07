import 'package:trust_wallet_scm/data/dto/token_changes_dto.dart';

class TokenChanges {
  final double changePercent;
  final double price;

  TokenChanges({
    required this.changePercent,
    required this.price,
  });

  factory TokenChanges.fromDTO(TokenChangesDTO dto) => TokenChanges(
        changePercent: double.tryParse(dto.priceChangePercent) ?? 0.0,
        price: double.tryParse(dto.lastPrice) ?? 0.0,
      );
}
