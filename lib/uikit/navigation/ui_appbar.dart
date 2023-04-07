import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class UIAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _appBarHeight = 64.0;

  final String title;
  final List<Widget>? actions;

  const UIAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    return AppBar(
      elevation: 0.0,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: _appBarHeight,
      backgroundColor: theme.background,
      title: Text(title, style: UITextStyle.header(theme)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}
