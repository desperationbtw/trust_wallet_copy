import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class UIButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isProgress;

  const UIButton({
    super.key,
    required this.label,
    this.onTap,
    this.isProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));
    final theme = UITheme.of(context);
    return Material(
      color: theme.accent,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        child: SizedBox(
          height: 36,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: _ButtonBody(
              label: label,
              theme: theme,
              isProgress: isProgress,
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonBody extends StatelessWidget {
  final String label;
  final UIThemeData theme;
  final bool isProgress;
  const _ButtonBody({
    required this.label,
    required this.theme,
    this.isProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: isProgress ? 0 : 1,
      alignment: AlignmentDirectional.center,
      children: [
        Visibility(
          visible: isProgress,
          child: const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.red, //todo: replace
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: UITextStyle.caption(theme, color: theme.textWhite),
            )
          ],
        ),
      ],
    );
  }
}
