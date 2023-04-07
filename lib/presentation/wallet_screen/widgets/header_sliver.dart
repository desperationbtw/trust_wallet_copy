import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';

class HeaderSliver extends StatelessWidget {
  final String walletName;
  final double balance;

  const HeaderSliver({
    super.key,
    required this.walletName,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final fixedBalance = CurrencyFormat.format(balance, decimalDigits: 2);
    final theme = UITheme.of(context);

    return SliverAppBar(
      leading: const Icon(Icons.notifications_none_rounded, size: 28),
      actions: const [Icon(Icons.tune_rounded, size: 28), SizedBox(width: 16.0)],
      pinned: true,
      toolbarHeight: 64,
      expandedHeight: 274,
      flexibleSpace: Container(
        padding: EdgeInsets.only(bottom: 36.0, top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          color: theme.background,
        ),
        child: FlexibleSpaceBar(
          expandedTitleScale: 1.3,
          collapseMode: CollapseMode.parallax,
          centerTitle: true,
          background: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(walletName, style: UITextStyle.subTitle(theme, color: theme.text600, fontWeight: FontWeight.w400)),
                    Icon(Icons.arrow_drop_down, color: theme.text600)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UIIconButton(Icons.arrow_upward_rounded, title: 'Отправить', foregroundColor: theme.accentDark),
                      UIIconButton(Icons.arrow_downward_rounded, title: 'Получить', foregroundColor: theme.accentDark),
                      UIIconButton(Icons.credit_card_rounded, title: 'Купить', foregroundColor: theme.accentDark),
                      UIIconButton(Icons.sync_alt_outlined, title: 'Обмен', foregroundColor: theme.accentDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
          title: Align(
            child: Text('$fixedBalance \$', style: UITextStyle.custom(theme, fontSize: fixedBalance.characters.length > 5 ? 22 : 32)),
          ),
        ),
      ),
      bottom: ColoredTabBar(
        color: theme.background,
        tabBar: TabBar(
          labelColor: theme.accent,
          unselectedLabelColor: theme.text800,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 32.0),
          tabs: const [
            Tab(text: 'Токены'),
            Tab(text: 'NFTs'),
          ],
        ),
      ),
    );
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  @override
  final Color color;
  final TabBar tabBar;

  ColoredTabBar({
    super.key,
    required this.color,
    required this.tabBar,
  });

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: tabBar,
    );
  }
}
