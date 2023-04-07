part of 'tech_screen_bloc.dart';

abstract class TechScreenState {}

class TechScreenProcessingState extends TechScreenState {}

class TechScreenContentState extends TechScreenState {
  final User? user;
  final String? error;

  TechScreenContentState({this.user, this.error});
}

class TechScreenGoodAuthState extends TechScreenState {
  final User user;

  TechScreenGoodAuthState({required this.user});
}

class TechScreenMessageState extends TechScreenState {
  final String message;

  TechScreenMessageState({required this.message});
}
