import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class UIListTile extends StatelessWidget {
  final String? lable;
  final Widget? middleWidget;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? action;
  final bool hasDivider;
  final EdgeInsetsGeometry padding;
  final Color? background;

  const UIListTile({
    super.key,
    this.lable,
    this.middleWidget,
    this.onTap,
    this.leading,
    this.action,
    this.hasDivider = true,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    this.background,
  }) : assert(middleWidget != null || lable != null, 'MIDDLE & LABLE == NULL');

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return Material(
      color: background ?? theme.ui300,
      child: InkWell(
          onTap: onTap ?? () {},
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (leading != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: leading!,
                  ),
                Expanded(
                  child: middleWidget ?? Text(lable!, style: UITextStyle.button(theme)),
                ),
                if (action != null) action!,
              ],
            ),
          ),
        ),
    );
  }
}
