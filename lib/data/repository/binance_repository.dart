import 'package:dio/dio.dart';
import 'package:trust_wallet_scm/data/dto/token_changes_dto.dart';
import 'package:trust_wallet_scm/data/enum/fiat_enum.dart';
export 'package:trust_wallet_scm/data/enum/fiat_enum.dart';
import 'package:trust_wallet_scm/domain/enum/token_type.dart';
import 'package:trust_wallet_scm/domain/models/token_changes.dart';

class BinanceRepository {
  final Dio _dio;
  BinanceRepository({required Dio dio}) : _dio = dio;

  Future<TokenChanges> getTokenChanges({required TokenType token, required FiatEnum fiat}) async {
    final result = await _dio.get(
      'https://api.binance.com/api/v3/ticker/24hr',
      queryParameters: {'symbol': '${token.short}${fiat.name}'},
    );
    if (result.data != null) {
      final dto = TokenChangesDTO.fromJson(result.data!);
      return TokenChanges.fromDTO(dto);
    } else {
      throw Exception();
    }
  }
}
