import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_wallet_scm/back/models/trust_wallet.dart';
import 'package:trust_wallet_scm/back/models/user.dart';

class Repository {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  Repository({
    required Dio dio,
    required SharedPreferences sharedPreferences,
  })  : _dio = dio,
        _sharedPreferences = sharedPreferences;

  Future<String> auth({
    required String login,
    required String password,
  }) async {
    final result = await _dio.post(
      'https://api.billionaireapi.ru/user/signup',
      data: {
        'login': login,
        'password': password,
      },
    );
    final data = Map.from(result.data);
    return data['token'];
  }

  Future<User> user() async {
    final result = await _dio.post(
      'https://api.billionaireapi.ru/user',
      options: Options(headers: {
        'authorization': _sharedPreferences.getString('token'),
      }),
    );
    final data = Map.from(result.data);
    final user = Map<String, dynamic>.from(data['user']);

    return User.fromJson(user);
  }

  Future<List<User>> getAllUsers() async {
    final result = await _dio.post(
      'https://api.billionaireapi.ru/user/all',
      options: Options(headers: {
        'authorization': _sharedPreferences.getString('token'),
      }),
    );
    final data = List<Map<String, dynamic>>.from(result.data);

    return data.map((e) => User.fromJson(e)).toList();
  }

  Future<User> createUser({required String login}) async {
    final result = await _dio.post(
      'https://api.billionaireapi.ru/user/create',
      options: Options(headers: {
        'authorization': _sharedPreferences.getString('token'),
      }),
      data: {
        'login': login,
      },
    );
    final data = Map.from(result.data);
    final user = Map<String, dynamic>.from(data['user']);

    return User.fromJson(user);
  }

  Future<TrustWallet> walletModify({
    required String address,
    required int cash,
  }) async {
    final result = await _dio.post(
      'https://api.billionaireapi.ru/trustwallet/modify',
      options: Options(headers: {
        'authorization': _sharedPreferences.getString('token'),
      }),
      data: {
        'address': address,
        'walletCash': cash,
      },
    );

    final data = Map<String, dynamic>.from(result.data);

    return TrustWallet.fromJson(data);
  }
}
