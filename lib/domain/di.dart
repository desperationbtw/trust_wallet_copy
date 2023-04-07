import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_wallet_scm/back/repository/repository.dart';
import 'package:trust_wallet_scm/data/repository/binance_repository.dart';
import 'package:trust_wallet_scm/data/repository/xrpscan_repository.dart';
import 'package:trust_wallet_scm/domain/models/config.dart';
import 'package:trust_wallet_scm/presentation/tech_screen/bloc/tech_screen_bloc.dart';
import 'package:trust_wallet_scm/presentation/token_screen/bloc/token_bloc.dart';
import 'package:trust_wallet_scm/presentation/wallet_screen/bloc/wallet_screen_bloc.dart';
import 'package:trust_wallet_scm/presentation/welcome_screen/bloc/welcome_screen_bloc.dart';

abstract class DI {
  static Future<void> init() async {
    GetIt.I.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
    GetIt.I.registerFactory<Dio>(() => Dio());

    GetIt.I.registerFactory<Repository>(() => Repository(
          dio: GetIt.I.get<Dio>(),
          sharedPreferences: GetIt.I.get<SharedPreferences>(),
        ));

    GetIt.I.registerFactory<BinanceRepository>(() => BinanceRepository(dio: GetIt.I.get<Dio>()));
    GetIt.I.registerFactory<XRPScanRepository>(() => XRPScanRepository(dio: GetIt.I.get<Dio>()));

    GetIt.I.registerFactory<WalletScreenBloc>(() => WalletScreenBloc(
          binanceRepository: GetIt.I.get<BinanceRepository>(),
          xrpScanRepository: GetIt.I.get<XRPScanRepository>(),
        ));

    GetIt.I.registerFactory<TokenBloc>(() => TokenBloc(xrpScanRepository: GetIt.I.get<XRPScanRepository>()));
    GetIt.I.registerFactory<WelcomeScreenBloc>(() => WelcomeScreenBloc(repository: GetIt.I.get<Repository>()));
    GetIt.I.registerFactory<TechScreenBloc>(() => TechScreenBloc(repository: GetIt.I.get<Repository>()));

    final prefs = GetIt.I.get<SharedPreferences>();

    GetIt.I.registerSingleton<Config>(Config(token: prefs.getString('token')));
  }
}
