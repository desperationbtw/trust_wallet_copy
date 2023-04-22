import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';
import 'package:trust_wallet_scm/domain/models/token.dart';
import 'package:trust_wallet_scm/domain/models/transaction.dart';
import 'package:trust_wallet_scm/presentation/token_screen/token_screen.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';

class TransactionScreen extends StatefulWidget {
  /// Токен
  final Token token;

  /// Транзакция
  final TransactionUI transaction;

  const TransactionScreen({
    super.key,
    required this.token,
    required this.transaction,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return Scaffold(
      appBar: UIAppBar(
        title: 'Перевод',
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: Center(
        child: Column(
          children: [
            _Values(token: widget.token, transaction: widget.transaction),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    _CardLine(
                      title: 'Дата',
                      hasInfo: false,
                      child: Text(
                        _transactionDate(widget.transaction.date),
                        style: UITextStyle.custom(theme, fontSize: 15, color: const Color(0xff95a9c2)),
                      ),
                    ),
                    const Divider(indent: 16.0, endIndent: 16.0, color: Color(0xff000002), height: 1),
                    _CardLine(
                      title: 'Статус',
                      hasInfo: true,
                      child: Text(
                        widget.transaction.status.label,
                        style: UITextStyle.custom(theme, fontSize: 15, color: const Color(0xff95a9c2)),
                      ),
                    ),
                    const Divider(indent: 16.0, endIndent: 16.0, color: Color(0xff000002), height: 1),
                    _CardLine(
                      title: 'Получатель',
                      hasInfo: false,
                      child: UIDropDownButton<int>(
                        offset: const Offset(0.0, 20.0),
                        items: [
                          UIDropDownItem(text: 'Скопировать', value: 0),
                          UIDropDownItem(text: 'Просмотр в обозревателе блоков', value: 1),
                        ],
                        onSelected: (val) async {
                          if (val == 0) {
                            await Clipboard.setData(ClipboardData(text: widget.transaction.partner));
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  margin: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 50.0),
                                  backgroundColor: const Color(0xff090909),
                                  content: Row(
                                    children: [
                                      Text(
                                        'Скопировать',
                                        style: UITextStyle.custom(theme, fontSize: 16.0, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        child: ExtendedText(
                                          widget.transaction.partner,
                                          maxLines: 1,
                                          overflowWidget: TextOverflowWidget(
                                            position: TextOverflowPosition.middle,
                                            align: TextOverflowAlign.center,
                                            child: Text(
                                              '...',
                                              style: UITextStyle.caption(theme, color: const Color(0xff95a9c2)).copyWith(height: 1.3),
                                            ),
                                          ),
                                          style: UITextStyle.custom(theme, fontSize: 16, color: const Color(0xff95a9c2)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: ExtendedText(
                          widget.transaction.partner,
                          maxLines: 1,
                          overflowWidget: TextOverflowWidget(
                            position: TextOverflowPosition.middle,
                            align: TextOverflowAlign.center,
                            child: Text(
                              '...',
                              style: UITextStyle.caption(theme, color: const Color(0xff95a9c2)).copyWith(height: 1.3),
                            ),
                          ),
                          style: UITextStyle.custom(theme, fontSize: 14, color: const Color(0xff95a9c2)),
                        ),
                      ),
                    ),
                    const Divider(indent: 16.0, endIndent: 16.0, color: Color(0xff000002), height: 1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    _CardLine(
                      title: 'Сетевой сбор',
                      hasInfo: true,
                      child: Text(
                        '${CurrencyFormat.format(widget.transaction.comission)} ${widget.token.type.short}\n(${CurrencyFormat.format(widget.transaction.comission * widget.token.price!)} \$)',
                        textAlign: TextAlign.end,
                        style: UITextStyle.custom(theme, fontSize: 14, color: const Color(0xff95a9c2)),
                      ),
                    ),
                    if (widget.transaction.accepts.isNotEmpty)
                      Column(
                        children: [
                          const Divider(indent: 16.0, endIndent: 16.0, color: Color(0xff000002), height: 1),
                          _CardLine(
                            title: 'Подтверждения',
                            hasInfo: false,
                            child: Text(
                              '--',
                              style: UITextStyle.subTitle(theme, color: theme.textBlue),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  await FlutterWebBrowser.openWebPage(
                    url: "https://bithomp.com/explorer/${widget.transaction.hash}",
                    customTabsOptions: const CustomTabsOptions(
                      colorScheme: CustomTabsColorScheme.dark,
                      shareState: CustomTabsShareState.off,
                      instantAppsEnabled: false,
                      showTitle: false,
                      urlBarHidingEnabled: true,
                    ),
                  );
                },
                child: Text(
                  'ПОДРОБНЕЕ',
                  style: UITextStyle.buttonText(theme, color: theme.textBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _transactionDate(DateTime date) {
    if (date.isToday()) return 'Сегодня${DateFormat(", hh:mm", 'ru').format(date)}';
    if (date.isYesterday()) return 'Вчера${DateFormat(", hh:mm", 'ru').format(date)}';
    return DateFormat("dd MMM, hh:mm", 'ru').format(date);
  }
}

class _Values extends StatelessWidget {
  /// Токен
  final Token token;

  /// Транзакция
  final TransactionUI transaction;

  const _Values({
    required this.token,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final percentColor = transaction.count > 0 ? const Color(0xff49a397) : const Color(0xffcf493d);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('${transaction.count > 0 ? '+' : ''}${CurrencyFormat.format(transaction.count)} ${token.type.short}',
              style: UITextStyle.valueHeader(theme, color: percentColor)),
          Text('≈ ${CurrencyFormat.format(transaction.count * token.price!, decimalDigits: 2)} \$',
              style: UITextStyle.subTitle(theme, color: theme.textBlue)),
        ],
      ),
    );
  }
}

class _CardLine extends StatelessWidget {
  final String title;
  final bool hasInfo;
  final Widget child;

  const _CardLine({
    required this.title,
    required this.hasInfo,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title),
              const SizedBox(width: 8.0),
              if (hasInfo)
                Icon(
                  Icons.info,
                  color: theme.navigationBarUnselectedForeground,
                  size: 16.0,
                ),
            ],
          ),
          Expanded(
              child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: child,
          )),
        ],
      ),
    );
  }
}
