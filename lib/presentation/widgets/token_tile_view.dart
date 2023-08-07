import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';

import '../../domain/models/token.dart';

class TokenTileView extends StatelessWidget {
  final Token token;
  final VoidCallback? onTap;

  const TokenTileView({
    super.key,
    required this.token,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final percentColor = token.percent == null
        ? null
        : token.percent! > 0
            ? theme.green
            : theme.red;

    return UIListTile(
      onTap: onTap,
      background: Colors.transparent,
      leading: Image.asset(token.type.logoAsset, width: 42, height: 42),
      middleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(token.type.short, style: UITextStyle.titleMed(theme)),
          Text(token.type.name, style: UITextStyle.caption(theme, color: theme.text400)),
        ],
      ),
      action: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${CurrencyFormat.format(token.price!, decimalDigits: 2)} \$',
            style: UITextStyle.titleMed(theme),
          ),
          Text(
            '${token.percent! > 0 ? '+' : ''}${CurrencyFormat.format(token.percent!, decimalDigits: 2)}%',
            style: UITextStyle.caption(theme, color: percentColor),
          ),
        ],
      ),
    );
  }
}
