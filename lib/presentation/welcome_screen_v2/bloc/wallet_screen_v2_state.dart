part of 'wallet_screen_v2_bloc.dart';

abstract class WelcomeScreenV2State {
  final List<Token> tokens;

  WelcomeScreenV2State({
    required this.tokens,
  });
}

class WelcomeScreenV2ContentState extends WelcomeScreenV2State {
  WelcomeScreenV2ContentState({
    required super.tokens,
  });
}

class WelcomeScreenV2InitialState extends WelcomeScreenV2State {
  WelcomeScreenV2InitialState() : super(tokens: []);
}

class WelcomeScreenV2ProcessingState extends WelcomeScreenV2State {
  WelcomeScreenV2ProcessingState.fromState(
    WelcomeScreenV2State state, {
    List<Token>? tokens,
  }) : super(
          tokens: tokens ?? state.tokens,
        );
}
