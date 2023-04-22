import 'dart:async';
import 'dart:math';

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
        super(WalletScreenInitialState()) {
    on<WalletScreenInitEvent>(_handleWalletScreenInitEvent);
  }

  FutureOr<void> _handleWalletScreenInitEvent(WalletScreenInitEvent event, Emitter<WalletScreenState> emit) async {
    var random = Random();

    var items = List.from(TokenType.values);
    items.shuffle();
    items = items.sublist(0, random.nextInt(items.length - 2) + 2);
    if (!items.contains(TokenType.ripple)) items.add(TokenType.ripple);

    emit(WalletScreenProcessingState.fromState(
      state,
      tokens: items.map((e) => Token(type: e, count: 0)).toList(),
    ));

    final config = GetIt.I.get<Config>();
    final xrpAccount = await _xrpScanRepository.getAccount(wallet: config.user!.trustWallet.address);

    final list = <Token>[];

    for (var item in items) {
      final diff = await _binanceRepository.getTokenChanges(token: item, fiat: FiatEnum.usdt);
      final hasBalance = random.nextInt(10) > 7;
      final balance = hasBalance ? random.nextDouble() * 20 : 0;
      list.add(Token(
        type: item,
        price: diff.price,
        percent: diff.changePercent,
        count: item != TokenType.ripple ? balance / diff.price : double.tryParse(xrpAccount.xrpBalance) ?? 0,
      ));
    }

    list.sort((a, b) => b.count.compareTo(a.count));

    emit(WalletScreenContentState(walletName: 'Кошелек 1', tokens: list, user: config.user!));
  }
}
