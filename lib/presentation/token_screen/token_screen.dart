import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:trust_wallet_scm/domain/models/token.dart';
import 'package:trust_wallet_scm/domain/models/transaction.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:collection/collection.dart" show groupBy;

import 'bloc/token_bloc.dart';
import 'widgets/transaction_tile.dart';

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }
}

class TokenScreen extends StatefulWidget {
  final Token token;

  const TokenScreen({
    super.key,
    required this.token,
  });

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  late TokenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<TokenBloc>();
    _bloc.add(TokenUpdateTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final percentColor = widget.token.percent > 0 ? theme.green : theme.red;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: UIAppBar(
        title: widget.token.type.short,
        actions: const [
          Icon(Icons.credit_card, size: 28),
          SizedBox(width: 16.0),
          Icon(UIIcons.graph, size: 28),
          SizedBox(width: 16.0),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: theme.ui100,
        color: theme.text800,
        strokeWidth: 2,
        onRefresh: () async {
          _bloc.add(TokenUpdateTransactionsEvent());
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('COIN', style: UITextStyle.custom(theme, fontSize: 14.0, color: const Color(0xffc3c6cf))),
                  Row(
                    children: [
                      Text(
                        '${CurrencyFormat.format(widget.token.price)} \$',
                        style: UITextStyle.custom(theme, fontSize: 14.0, color: const Color(0xffc3c6cf)),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '${widget.token.percent > 0 ? '+' : ''}${CurrencyFormat.format(widget.token.percent, decimalDigits: 2)}%',
                        style: UITextStyle.custom(theme, fontSize: 14.0, color: percentColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Image.asset(widget.token.type.logoAsset, width: 42, height: 42),
            const SizedBox(height: 8.0),
            Text(
              '${CurrencyFormat.format(widget.token.count)} ${widget.token.type.short}',
              style: UITextStyle.custom(theme, fontSize: 28.0),
              textAlign: TextAlign.center,
            ),
            Text(
              '≈${CurrencyFormat.format(widget.token.fiatCount, decimalDigits: 2)} \$',
              style: UITextStyle.custom(theme, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UIIconButton(Icons.arrow_upward_rounded, title: 'Отправить', foregroundColor: theme.accentDark),
                UIIconButton(Icons.arrow_downward_rounded, title: 'Получить', foregroundColor: theme.accentDark),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(color: Color(0xff8e9196), thickness: 0.5),
            BlocBuilder<TokenBloc, TokenState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is TokenProcessingState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2, color: theme.accent),
                    ),
                  );
                }
                if (state is TokenContentState) {
                  if (state.transactions.isEmpty) return const Text('empty');
                  return _transactionsBuilder(state: state, theme: theme, token: widget.token);
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _transactionsBuilder({
    required TokenContentState state,
    required UIThemeData theme,
    required Token token,
  }) {
    final dates = groupBy(state.transactions, (TransactionUI transaction) {
      return transaction.date.isToday()
          ? "Сегодня"
          : transaction.date.isYesterday()
              ? "Вчера"
              : DateFormat("dd MMM yг.", 'ru').format(transaction.date);
    });

    final items = <Widget>[];
    for (final date in dates.keys) {
      items.add(Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Text(date, style: UITextStyle.subTitle(theme, color: const Color(0xff8d919a), fontWeight: FontWeight.w500)),
      ));
      dates[date]?.forEach((e) {
        items.add(TransactionTile(
          token: token,
          transaction: e,
        ));
      });
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }
}
