import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

/// Элемент нижнего навигационного меню.
class UIBottomNavigationItem extends PersistentBottomNavBarItem {
  /// Иконка.
  final IconData iconData;

  /// Заголовок
  final String title;

  /// Количество уведомлений.
  final int value;

  UIBottomNavigationItem({
    required this.iconData,
    required this.title,
    this.value = 0,
  }) : super(icon: const SizedBox.shrink());
}
