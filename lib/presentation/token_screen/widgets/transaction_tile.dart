import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/domain/models/token.dart';
import 'package:trust_wallet_scm/domain/models/transaction.dart';
import 'package:trust_wallet_scm/presentation/transaction_screen/transaction_screen.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';

/// Линия транзакции
class TransactionTile extends StatelessWidget {
  /// Токен
  final Token token;

  /// Транзакция
  final TransactionUI transaction;

  const TransactionTile({
    super.key,
    required this.token,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final percentColor = transaction.count > 0 ? theme.green : theme.red;

    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TransactionScreen(token: token, transaction: transaction),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff43484e),
              child: Icon(transaction.count > 0 ? UIIcons.dropdown_down : UIIcons.dropdown_top, color: const Color(0xffc3c6cf), size: 20),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Перевод',
                    style: UITextStyle.title(theme),
                  ),
                  Row(
                    children: [
                      Text(transaction.count > 0 ? 'От: ' : 'Кому: ', style: UITextStyle.caption(theme)),
                      Expanded(
                        child: ExtendedText(
                          transaction.partner,
                          maxLines: 1,
                          overflowWidget: TextOverflowWidget(
                            position: TextOverflowPosition.middle,
                            align: TextOverflowAlign.center,
                            child: Text(
                              '...',
                              style: UITextStyle.caption(theme, color: const Color(0xffc3c6cf)).copyWith(height: 1.3),
                            ),
                          ),
                          style: UITextStyle.caption(theme, color: const Color(0xffc3c6cf)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '${transaction.count > 0 ? '+' : ''}${CurrencyFormat.format(transaction.count)} ${token.type.short}',
                textAlign: TextAlign.end,
                style: UITextStyle.title(theme, color: percentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
