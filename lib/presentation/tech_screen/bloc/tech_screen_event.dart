part of 'tech_screen_bloc.dart';

abstract class TechScreenEvent {}

class TechScreenInitEvent extends TechScreenEvent {}

class TechScreenAuthEvent extends TechScreenEvent {
  final String login;

  final String password;

  TechScreenAuthEvent({
    required this.login,
    required this.password,
  });
}
