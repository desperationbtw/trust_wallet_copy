import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_wallet_scm/back/models/user.dart';
import 'package:trust_wallet_scm/back/repository/repository.dart';
import 'package:trust_wallet_scm/domain/models/config.dart';

part 'tech_screen_event.dart';
part 'tech_screen_state.dart';

class TechScreenBloc extends Bloc<TechScreenEvent, TechScreenState> {
  final Repository _repository;

  TechScreenBloc({
    required Repository repository,
  })  : _repository = repository,
        super(TechScreenProcessingState()) {
    on<TechScreenInitEvent>(_handleTechScreenInitEvent);
    on<TechScreenAuthEvent>(_handleTechScreenAuthEvent);
  }

  FutureOr<void> _handleTechScreenInitEvent(TechScreenInitEvent event, Emitter<TechScreenState> emit) async {
    final config = GetIt.I.get<Config>();

    emit(TechScreenContentState(user: config.user));
  }

  FutureOr<void> _handleTechScreenAuthEvent(TechScreenAuthEvent event, Emitter<TechScreenState> emit) async {
    emit(TechScreenProcessingState());
    final prefs = GetIt.I.get<SharedPreferences>();
    final config = GetIt.I.get<Config>();

    late User user;

    try {
      final token = await _repository.auth(login: event.login, password: event.password);

      prefs.setString('token', token);
      config.token = token;

      user = await _repository.user();
    } on DioError catch (e) {
      emit(TechScreenMessageState(message: 'Неудачная авторизация'));
      return emit(TechScreenContentState(user: null, error: e.message ?? 'MSG: ${e.error}\nTRACE: ${e.stackTrace}'));
    } catch (e) {
      emit(TechScreenMessageState(message: 'Неудачная авторизация'));
      return emit(TechScreenContentState(user: null, error: e.toString()));
    }

    emit(TechScreenGoodAuthState(user: user));
  }
}
