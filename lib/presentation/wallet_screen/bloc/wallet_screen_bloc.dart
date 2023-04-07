import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trust_wallet_scm/back/models/user.dart';
import 'package:trust_wallet_scm/data/repository/binance_repository.dart';
import 'package:trust_wallet_scm/data/repository/xrpscan_repository.dart';
import 'package:trust_wallet_scm/domain/models/config.dart';
import 'package:trust_wallet_scm/domain/models/token.dart';

part 'wallet_screen_event.dart';
part 'wallet_screen_state.dart';

class WalletScreenBloc extends Bloc<WalletScreenEvent, WalletScreenState> {
  final BinanceRepository _binanceRepository;
  final XRPScanRepository _xrpScanRepository;

  WalletScreenBloc({
    required BinanceRepository binanceRepository,
    required XRPScanRepository xrpScanRepository,
  })  : _binanceRepository = binanceRepository,
        _xrpScanRepository = xrpScanRepository,
        super(WalletScreenProcessingState()) {
    on<WalletScreenInitEvent>(_handleWalletScreenInitEvent);
  }

  FutureOr<void> _handleWalletScreenInitEvent(WalletScreenInitEvent state, Emitter<WalletScreenState> emit) async {
    emit(WalletScreenProcessingState());
    final config = GetIt.I.get<Config>();
    final xrpDiff = await _binanceRepository.getTokenChanges(token: TokenEnum.xrp, fiat: FiatEnum.usdt);
    final xrpAccount = await _xrpScanRepository.getAccount(wallet: config.user!.trustWallet.address);
    final list = [
      Token(
        type: TokenType.ripple,
        price: xrpDiff.price,
        percent: xrpDiff.changePercent,
        count: double.tryParse(xrpAccount.xrpBalance) ?? 0,
      ),
    ];

    emit(WalletScreenContentState(walletName: 'Кошелек 1', tokens: list, user: config.user!));
  }
}
