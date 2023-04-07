import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/buttons/ui_button_content.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

/// Обычная кнопка.
///
/// Что бы изменить стиль используйте [UIIconButton.outlined] или [UIIconButton.text]
/// При отсутствии коллбека имеет выключенный стиль независимо от используемого
class UIIconButton extends StatelessWidget {
  /// Иконка кнопки
  final IconData icon;

  /// Тайтл
  final String title;

  /// Индикатор состояния загрузки, при [true] внутри кнопки отображается [CurcilarProgressIndicator]
  final bool isLoading;

  /// Callback при нажатии
  final VoidCallback? onTap;

  final Color foregroundColor;

  const UIIconButton(
    this.icon, {
    super.key,
    required this.title,
    this.isLoading = false,
    this.onTap,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0));

    return SizedBox(
      width: 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: theme.accent,
            shape: shape,
            child: InkWell(
              customBorder: shape,
              onTap: onTap,
              child: SizedBox(
                height: 46.0,
                width: 46.0,
                child: UIButtonContent(
                  isLoading: isLoading,
                  foregroundColor: foregroundColor,
                  iconData: icon,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(title, style: UITextStyle.iconButton(theme, color: theme.accent)),
        ],
      ),
    );
  }
}
