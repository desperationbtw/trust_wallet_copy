import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/buttons/ui_button_content.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

/// Кнопка нижнего меню навигации.
class UIBottomNavigationButton extends StatelessWidget {
  /// Иконка.
  final IconData icon;

  /// Заголовок
  final String title;

  /// Количество уведомлений.
  final int value;

  /// Выбранна ли плитка навигации
  final bool isSelected;

  const UIBottomNavigationButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final foreground = isSelected ? theme.navigationBarSelectedForeground : theme.navigationBarUnselectedForeground;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
            child: Material(
              color: isSelected ? theme.navigationBarSelected : Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              child: UIBadge.notification(
                fit: StackFit.expand,
                count: value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: UIButtonContent(
                    isLoading: false,
                    foregroundColor: foreground,
                    iconData: icon,
                    iconSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 2.0),
        Text(title, style: UITextStyle.navigation(theme, color: foreground)),
      ],
    );
  }
}
