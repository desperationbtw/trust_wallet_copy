import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../uikit.dart';

class UISwitchSelector<T> extends StatelessWidget {
  final void Function(T)? onChanged;
  final T value;
  final List<UISwitchData<T>> values;
  const UISwitchSelector({
    super.key,
    this.onChanged,
    required this.value,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: values
          .mapIndexed((i, e) => _UISwitchButton<T>(
                value: e,
                onTap: (e) => onChanged?.call(e),
                isSelected: value == e.value,
                position: _position(i, values.length),
              ))
          .toList(),
    );
  }

  UISwitchPosition _position(int index, int count) {
    if (index == 0) return UISwitchPosition.left;
    if (index == count - 1) return UISwitchPosition.right;
    return UISwitchPosition.middle;
  }
}

class UISwitchData<T> {
  final T value;
  final String title;
  final IconData? activeIcon;
  final IconData? disabledIcon;

  UISwitchData({
    required this.value,
    required this.title,
    this.activeIcon,
    this.disabledIcon,
  });
}

class _UISwitchButton<T> extends StatelessWidget {
  final UISwitchData<T> value;
  final void Function(T) onTap;
  final UISwitchPosition position;
  final bool isSelected;

  const _UISwitchButton({
    required this.value,
    required this.onTap,
    required this.position,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(position == UISwitchPosition.left ? 16.0 : 0.0),
        right: Radius.circular(position == UISwitchPosition.right ? 16.0 : 0.0),
      ),
    );
    final theme = UITheme.of(context);
    return Material(
      color: isSelected ? theme.accent : theme.ui100, //todo: replace
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: () => onTap.call(value.value),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                if (value.activeIcon != null)
                  Row(
                    children: [
                      Icon(
                        value.activeIcon,
                        color: isSelected ? theme.textWhite : theme.text800,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                    ],
                  ),
                Text(
                  value.title,
                  style: UITextStyle.caption(theme, color: isSelected ? theme.textWhite : null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum UISwitchPosition {
  left,
  middle,
  right,
}
