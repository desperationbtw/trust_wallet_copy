import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_wallet_scm/uikit/foundation/ui_theme/cubit/ui_theme_state.dart';

import '../ui_theme_data.dart';
import '../ui_theme_type.dart';
export './ui_theme_state.dart';

class UIThemeCubit extends Cubit<UIThemeState> {
  UIThemeCubit() : super(UIThemeState(theme: UIThemeData.dark()));

  void selectTheme(UIThemeType type) => emit(UIThemeState(theme: UIThemeData.fromType(type)));
}
