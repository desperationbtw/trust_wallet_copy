part of './wallet_screen_bloc.dart';

abstract class WalletScreenState {
  final String walletName;
  final List<Token> tokens;

  double get balance => tokens.fold(0, (v, e) => v += e.fiatCount ?? 0);

  WalletScreenState({
    required this.walletName,
    required this.tokens,
  });
}

class WalletScreenContentState extends WalletScreenState {
  final User user;

  WalletScreenContentState({
    required this.user,
    required super.walletName,
    required super.tokens,
  });
}

class WalletScreenInitialState extends WalletScreenState {
  WalletScreenInitialState() : super(tokens: [], walletName: 'Кошелек 1');
}

class WalletScreenProcessingState extends WalletScreenState {
  WalletScreenProcessingState.fromState(
    WalletScreenState state, {
    List<Token>? tokens,
    String? walletName,
  }) : super(
          tokens: tokens ?? state.tokens,
          walletName: walletName ?? state.walletName,
        );
}
