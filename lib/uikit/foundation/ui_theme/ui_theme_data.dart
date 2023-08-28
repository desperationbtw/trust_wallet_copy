import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/foundation/ui_theme/ui_theme_type.dart';

/// Данные темы
class UIThemeData {
  final UIThemeType _theme;

  final Color accent;
  final Color accentDark;
  final Color accentGray; //252a30
  final Color background;
  final Color ui100;
  final Color ui300;
  final Color ui400;
  final Color ui600;
  final Color ui800;
  final Color uiDisable;
  final Color textBlue; //95a9c2
  final Color textGray; //8d919a
  final Color text400;
  final Color text500;
  final Color text600;
  final Color text800;
  final Color textWhite;

  final Color navigationBarSelected; //42536d
  final Color navigationBarSelectedForeground; //b7d4ff
  final Color navigationBarUnselectedForeground; //68798d

  final Color green; //4ca297
  final Color red; //d44938

  final Color divider; //8e9196
  final Color border; //43484e
  final Color circleBackground; //383643

  UIThemeData.light({
    this.accent = const Color(0xFF303b44),
    this.accentDark = const Color(0xFF303b44),
    this.accentGray = const Color(0xff252a30),
    this.background = const Color(0xFFf0f0f0),
    this.ui100 = const Color(0xFFF5F5F5),
    this.ui300 = const Color(0xFFE0E0E0),
    this.ui400 = const Color(0xFFBDBDBD),
    this.ui600 = const Color(0xFF757575),
    this.ui800 = const Color(0xFF424242),
    this.uiDisable = const Color(0xFFE0E0E0),
    this.textBlue = const Color(0xFF9E9E9E),
    this.textGray = const Color(0xFF8c9099),
    this.text400 = const Color(0xFF9E9E9E),
    this.text500 = const Color(0xFF9E9E9E),
    this.text600 = const Color(0xFF9E9E9E),
    this.text800 = const Color(0xFF333333),
    this.textWhite = const Color(0xFFFDFDFD),
    this.navigationBarSelected = const Color(0xFFFDFDFD),
    this.navigationBarSelectedForeground = const Color(0xFFFDFDFD),
    this.navigationBarUnselectedForeground = const Color(0xFFFDFDFD),
    this.green = const Color(0xff4ca297),
    this.red = const Color(0xffd44938),
    this.divider = const Color(0xffd44938),
    this.border = const Color(0xff43484e),
    this.circleBackground = const Color(0xff383643),
  }) : _theme = UIThemeType.light;

  UIThemeData.dark({
    this.accent = const Color(0xffa1c8ff),
    this.accentDark = const Color(0xff00315a),
    this.accentGray = const Color(0xff252a30),
    this.background = const Color(0xff1b1c1e),
    this.ui100 = const Color(0xff252a30),
    this.ui300 = const Color(0xff1a222d),
    this.ui400 = const Color(0xffc3c6cf),
    this.ui600 = const Color(0xFFFDFDFD),
    this.ui800 = const Color(0xFFFDFDFD),
    this.uiDisable = const Color(0xFF474747),
    this.textBlue = const Color(0xff95a9c2),
    this.textGray = const Color(0xff8d919a),
    this.text400 = const Color(0xffc3c6cf),
    this.text500 = const Color(0xFFbbc8d9),
    this.text600 = const Color(0xffbcc9dc),
    this.text800 = const Color(0xFFe3e2e7),
    this.textWhite = const Color(0xFFFDFDFD),
    this.navigationBarSelected = const Color(0xff415266),
    this.navigationBarSelectedForeground = const Color(0xffb7d4ff),
    this.navigationBarUnselectedForeground = const Color(0xff68798d),
    this.green = const Color(0xff6cd9b2),
    this.red = const Color(0xfff7b7ae),
    this.divider = const Color(0xff8e9196),
    this.border = const Color(0xff43484e),
    this.circleBackground = const Color(0xff383643),
  }) : _theme = UIThemeType.dark;

  UIThemeType get type => _theme;

  factory UIThemeData.fromType(UIThemeType type) {
    switch (type) {
      case UIThemeType.light:
        return UIThemeData.light();
      case UIThemeType.dark:
        return UIThemeData.dark();
    }
  }
}
