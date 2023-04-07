import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/uikit/navigation/ui_bottom_navigation_button.dart';
import 'package:trust_wallet_scm/uikit/navigation/ui_bottom_navigation_item.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<UIBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(UIBottomNavigationItem item, bool isSelected) {
    return UIBottomNavigationButton(
      icon: item.iconData,
      title: item.title,
      value: item.value,
      isSelected: isSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return Container(
      color: theme.ui100,
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onItemSelected(index);
                  },
                  child: _buildItem(item, selectedIndex == index),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Нижнее меню навигации.
///
/// Обычно используется в [Scaffold.bottomNavigationBar].
///
class UIBottomNavigation extends StatelessWidget {
  /// Элементы навигации.
  final List<UIBottomNavigationItem> items;

  /// Индекс текущего выбранного элемента навигации из [items].
  final int selectedIndex;

  /// Коллбек на нажатие на элемент навигации с индексом [index].
  final void Function(int index) onSelectIndex;

  const UIBottomNavigation({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onSelectIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < items.length; ++index)
            Expanded(
              child: UIBottomNavigationButton(
                icon: items[index].iconData,
                title: items[index].title,
                value: items[index].value,
                isSelected: index == selectedIndex,
              ),
            ),
        ],
      ),
    );
  }
}
