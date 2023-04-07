part of 'token_bloc.dart';

abstract class TokenState {}

class TokenProcessingState extends TokenState {}

class TokenContentState extends TokenState {
  final List<TransactionUI> transactions;

  TokenContentState({required this.transactions});
}
