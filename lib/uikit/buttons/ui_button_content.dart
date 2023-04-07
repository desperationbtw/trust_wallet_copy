import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

/// Содержимое кнопок, имеет состояние загрузки
class UIButtonContent extends StatelessWidget {
  /// Тест кнопки
  final String? text;

  /// Иконка кнопки
  final IconData? iconData;

  /// Индикатор состояния загрузки, при [true] внутри кнопки отображается [CurcilarProgressIndicator]
  final bool isLoading;

  /// Цвет иконки и текста
  final Color? foregroundColor;

  /// Стиль текста, стандартно используется [UI2TextStyles.button]
  final TextStyle? textStyle;

  final double? iconSize;

  const UIButtonContent({
    Key? key,
    this.text,
    this.iconData,
    this.textStyle,
    this.iconSize,
    required this.isLoading,
    required this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final foregroundColor = this.foregroundColor ?? theme.ui600;

    return IndexedStack(
      index: isLoading ? 0 : 1,
      alignment: AlignmentDirectional.center,
      children: [
        Visibility(
          visible: isLoading,
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: foregroundColor,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: foregroundColor,
                size: iconSize,
              ),
            if (text != null && iconData != null) const SizedBox(width: 4),
            if (text != null)
              Text(
                text!.toUpperCase(),
                style: textStyle ?? UITextStyle.button(theme),
              ),
          ],
        ),
      ],
    );
  }
}
