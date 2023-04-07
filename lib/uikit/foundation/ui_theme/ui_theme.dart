import 'package:flutter/widgets.dart';
import 'package:trust_wallet_scm/uikit/foundation/ui_theme/ui_theme_data.dart';

export './ui_theme_type.dart';
export './cubit/ui_theme_cubit.dart';
export './cubit/ui_theme_state.dart';

class UITheme extends InheritedWidget {
  final UIThemeData theme;

  const UITheme({
    super.key,
    required super.child,
    required this.theme,
  });

  static UIThemeData of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<UITheme>();

    return inheritedTheme?.theme ?? UIThemeData.light();
  }

  @override
  bool updateShouldNotify(UITheme oldWidget) => oldWidget.theme != theme;
}
