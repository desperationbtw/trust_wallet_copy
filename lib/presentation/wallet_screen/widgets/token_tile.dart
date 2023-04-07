import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';

import '../../../domain/models/token.dart';

class TokenTile extends StatelessWidget {
  final Token token;
  final VoidCallback? onTap;

  const TokenTile({
    super.key,
    required this.token,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final percentColor = token.percent > 0 ? theme.green : theme.red;

    return UIListTile(
      onTap: onTap,
      background: Colors.transparent,
      leading: Image.asset(token.type.logoAsset, width: 42, height: 42),
      middleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(token.type.short, style: UITextStyle.titleMed(theme)),
          Row(
            children: [
              Text('${CurrencyFormat.format(token.price, decimalDigits: 2)} \$', style: UITextStyle.caption(theme, color: theme.text400)),
              const SizedBox(width: 4.0),
              Text('${token.percent > 0 ? '+' : ''}${CurrencyFormat.format(token.percent, decimalDigits: 2)}%', style: UITextStyle.caption(theme, color: percentColor)),
            ],
          )
        ],
      ),
      action: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(token.fiatCount != 0 ? CurrencyFormat.format(token.count) : '0', style: UITextStyle.titleMed(theme)),
          if (token.fiatCount != 0)
            Text('${CurrencyFormat.format(token.fiatCount, decimalDigits: 2)} \$', style: UITextStyle.caption(theme, color: theme.text400)),
        ],
      ),
    );
  }
}
