import 'package:dio/dio.dart';
import 'package:trust_wallet_scm/data/dto/transaction_dto.dart';
import 'package:trust_wallet_scm/data/dto/xrp_account.dart';
export 'package:trust_wallet_scm/data/enum/fiat_enum.dart';

class XRPScanRepository {
  final Dio _dio;

  XRPScanRepository({required Dio dio}) : _dio = dio;

  Future<TransactionDto> getTransactions({required String wallet}) async => _fetch<TransactionDto>(
        endpoint: 'https://api.xrpscan.com/api/v1/account/$wallet/transactions',
        deserialize: (data) => TransactionDto.fromJson(data),
      );

  Future<XRPAccount> getAccount({required String wallet}) async => _fetch<XRPAccount>(
        endpoint: 'https://api.xrpscan.com/api/v1/account/$wallet',
        deserialize: (data) => XRPAccount.fromJson(data),
      );

  Future<T> _fetch<T>({required String endpoint, required T Function(dynamic) deserialize}) async {
    final result = await _dio.get(endpoint);
    if (result.data != null) {
      return deserialize(result.data!);
    } else {
      throw Exception();
    }
  }
}
