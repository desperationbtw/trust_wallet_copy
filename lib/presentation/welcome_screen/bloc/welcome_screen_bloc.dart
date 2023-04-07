import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_wallet_scm/back/models/user.dart';
import 'package:trust_wallet_scm/back/repository/repository.dart';
import 'package:trust_wallet_scm/domain/models/config.dart';

part 'welcome_screen_state.dart';
part 'welcome_screen_event.dart';

class WelcomeScreenBloc extends Bloc<WelcomeScreenEvent, WelcomeScreenState> {
  final Repository _repository;

  WelcomeScreenBloc({
    required Repository repository,
  })  : _repository = repository,
        super(WelcomeScreenProcessingState()) {
    on<WelcomeScreenInitEvent>(_handleWelcomeScreenInitEvent);
  }

  FutureOr<void> _handleWelcomeScreenInitEvent(WelcomeScreenInitEvent event, Emitter<WelcomeScreenState> emit) async {
    final config = GetIt.I.get<Config>();
    final prefs = GetIt.I.get<SharedPreferences>();

    if (config.token != null) {
      try {
        config.user = await _repository.user();
      } catch (_) {}

      if (config.user == null) {
        prefs.remove('token');
        config.token = null;
        emit(WelcomeScreenWaitState());
      } else {
        emit(WelcomeScreenDoneState());
      }
    } else {
      emit(WelcomeScreenWaitState());
    }
  }
}
