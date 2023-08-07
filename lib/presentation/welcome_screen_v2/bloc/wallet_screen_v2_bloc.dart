import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:trust_wallet_scm/data/repository/binance_repository.dart';
import 'package:trust_wallet_scm/domain/models/token.dart';

part 'wallet_screen_v2_event.dart';
part 'wallet_screen_v2_state.dart';

class WelcomeScreenV2 extends Bloc<WelcomeScreenV2Event, WelcomeScreenV2State> {
  final BinanceRepository _binanceRepository;

  WelcomeScreenV2({
    required BinanceRepository binanceRepository,
  })  : _binanceRepository = binanceRepository,
        super(WelcomeScreenV2InitialState()) {
    on<WelcomeScreenV2InitEvent>(_handleWalletScreenInitEvent);
  }

  FutureOr<void> _handleWalletScreenInitEvent(WelcomeScreenV2InitEvent event, Emitter<WelcomeScreenV2State> emit) async {
    var random = Random();

    var items = List.from(TokenType.values);
    items.shuffle();
    items = items.sublist(0, random.nextInt(items.length - 2) + 2);
    if (!items.contains(TokenType.ripple)) items.add(TokenType.ripple);

    emit(WelcomeScreenV2ProcessingState.fromState(
      state,
      tokens: items.map((e) => Token(type: e, count: 0)).toList(),
    ));

    final list = <Token>[];

    for (var item in items) {
      final diff = await _binanceRepository.getTokenChanges(token: item, fiat: FiatEnum.usdt);
      list.add(Token(
        type: item,
        price: diff.price,
        percent: diff.changePercent,
        count: 1,
      ));
    }

    list.sort((a, b) => b.count.compareTo(a.count));

    emit(WelcomeScreenV2ContentState(tokens: list));
  }
}
