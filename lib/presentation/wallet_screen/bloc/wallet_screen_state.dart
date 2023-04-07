part of './wallet_screen_bloc.dart';

abstract class WalletScreenState {}

class WalletScreenContentState implements WalletScreenState {
  final String walletName;
  final List<Token> tokens;
  final User user;

  double get balance => tokens.fold(0, (v, e) => v += e.fiatCount);

  WalletScreenContentState({
    required this.walletName,
    required this.tokens,
    required this.user,
  });
}

class WalletScreenProcessingState implements WalletScreenState {}
