import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trust_wallet_scm/data/repository/xrpscan_repository.dart';
import 'package:trust_wallet_scm/domain/models/config.dart';

import 'package:trust_wallet_scm/domain/models/transaction.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final XRPScanRepository _xrpScanRepository;
  TokenBloc({required XRPScanRepository xrpScanRepository})
      : _xrpScanRepository = xrpScanRepository,
        super(TokenProcessingState()) {
    on<TokenUpdateTransactionsEvent>(_handleTokenUpdateTransactionsEvent);
  }

  FutureOr<void> _handleTokenUpdateTransactionsEvent(TokenUpdateTransactionsEvent event, Emitter<TokenState> emit) async {
    final config = GetIt.I.get<Config>();
    final xrpTransactions = await _xrpScanRepository.getTransactions(wallet: config.user!.trustWallet.address);
    final transactions = xrpTransactions.transactions
        .map(
          (e) => TransactionUI(
            status: TransactionStatus.complete,
            date: e.date,
            count: e.destination == config.user!.trustWallet.address ? e.amount.value / 1000000 : e.amount.value / 1000000 * -1,
            partner: e.destination,
            hash: e.hash,
            comission: 0.0005,
          ),
        )
        .toList();

    emit(TokenProcessingState());
    await Future.delayed(const Duration(milliseconds: 600));
    emit(TokenContentState(transactions: transactions));
  }
}
