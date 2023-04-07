import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/foundation/ui_theme/ui_text_style.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

/// Элемент попап списка
class UIDropDownItem<T> {
  /// Тайтл
  String text;

  /// Значение для коллбека
  T? value;

  UIDropDownItem({
    required this.text,
    this.value,
  });
}

class UIDropDownButton<T> extends StatelessWidget {
  /// Элементы для всплывающего списка
  final List<UIDropDownItem> items;

  /// Дочерний виджет кнопки
  final Widget? child;

  /// Смещение всплывающего списка меню
  ///
  /// Если не установлен, список будет расположен рядом с кнопкой
  final Offset offset;

  /// Коллбек на выбор элемента из попап списка
  final void Function(T)? onSelected;

  const UIDropDownButton({
    Key? key,
    required this.items,
    this.child,
    this.offset = const Offset(0, 0),
    this.onSelected,
  }) : super(key: key);

  void showPopupMenu(BuildContext context) {
    final theme = UITheme.of(context);

    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final itemsList = items
        .map(
          (e) => PopupMenuItem<T>(
            height: 38,
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 0.0, 10.0),
            value: e.value,
            child: Text(
              e.text,
              style: UITextStyle.custom(theme, fontSize: 15.0, color: Colors.white),
            ),
          ),
        )
        .toList();

    if (items.isNotEmpty) {
      showMenu<T>(
        context: context,
        elevation: 10,
        items: itemsList,
        position: position,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        surfaceTintColor: const Color(0xff262930),
        color: const Color(0xff262930),
      ).then<void>(
        (T? val) {
          if (val != null) {
            onSelected?.call(val);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onLongPress: () => showPopupMenu(context),
    );
  }
}
