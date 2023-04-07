import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

/// Бейдж.
class UIBadge extends StatelessWidget {
  /// Текст на бейдже.
  ///
  /// Если не задан, бейдж не отрисовывается.
  final String? text;

  /// Виджет, в углу которого будет находиться бейдж.
  ///
  /// Если не задан, отрисовывается только сам бейдж.
  final Widget? child;

  /// Отступ от текста в бейдже до границ бейджа.
  final EdgeInsets padding;

  /// Тип определения размеров виджета [child] и бейджа.
  ///
  /// Используется, только если задан [child].
  final StackFit fit;

  const UIBadge({
    Key? key,
    this.text,
    this.child,
    this.fit = StackFit.loose,
  })  : padding = const EdgeInsets.symmetric(horizontal: 8.0),
        super(key: key);

  /// Бейдж со счетчиком уведомлений.
  ///
  /// Отображает бейдж только в том случае, если число уведомлений положительное.
  UIBadge.notification({
    Key? key,
    required int count,
    this.child,
    this.fit = StackFit.loose,
  })  : padding = const EdgeInsets.symmetric(horizontal: 4),
        text = _createTextFromValue(count),
        super(key: key);

  /// Формирует надпись из количества уведомлений [value].
  static String? _createTextFromValue(int notificationsCount) {
    if (notificationsCount <= 0) return null;
    if (notificationsCount > 99) return '99+';
    return notificationsCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return _buildBadge(context);
    }

    return Stack(
      fit: fit,
      alignment: AlignmentDirectional.center,
      children: [
        child!,
        Positioned.fill(
          child: IgnorePointer(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: OverflowBox(
                    alignment: AlignmentDirectional.centerStart,
                    maxWidth: 50,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, left: 2),
                          child: _buildBadge(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(BuildContext context) {
    if (text == null) {
      return const SizedBox.shrink();
    }

    final theme = UITheme.of(context);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          padding: padding,
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: theme.accent,
          ),
        ),
        Text(
          text!,
          style: UITextStyle.badge(theme),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
