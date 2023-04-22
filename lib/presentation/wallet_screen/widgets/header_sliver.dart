import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';
import 'package:trust_wallet_scm/utils/currency_format.dart';

class HeaderSliver extends StatefulWidget {
  final String walletName;
  final double balance;

  const HeaderSliver({
    super.key,
    required this.walletName,
    required this.balance,
  });

  @override
  State<HeaderSliver> createState() => _HeaderSliverState();
}

class _HeaderSliverState extends State<HeaderSliver> {
  final mainContent = 280.0;
  // final additionalSize = 80.0;
  final additionalSize = 0.0;
  late String fixedBalance;
  late double expandedHeight;

  @override
  void initState() {
    super.initState();
    fixedBalance = CurrencyFormat.format(widget.balance, decimalDigits: 2);
    expandedHeight = mainContent + additionalSize;
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.notifications_none_rounded, size: 28),
          Icon(Icons.tune_rounded, size: 28),
        ],
      ),
      backgroundColor: theme.background,
      surfaceTintColor: theme.background,
      pinned: true,
      expandedHeight: expandedHeight,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final currentExtent = constraints.biggest.height;
          final precent = (currentExtent - 56) / (expandedHeight - 56);

          final opacityPrecent = precent > 0.15 ? (precent - 0.15) / 0.85 : 0;
          final fontSizePrecent = precent > 0.5 ? (precent - 0.5) / 0.5 : 0;
          final fontSizeFactor = (1 + (fixedBalance.characters.length > 5 ? 0.3 : 0.6) * fontSizePrecent);
          return FlexibleSpaceBarSettings(
            currentExtent: currentExtent,
            toolbarOpacity: 1.0,
            maxExtent: expandedHeight,
            minExtent: 56.0,
            child: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: (100.0 + additionalSize) * precent),
                child: Center(child: Text('$fixedBalance \$', style: UITextStyle.custom(theme, fontSize: 22 * fontSizeFactor))),
              ),
              background: Opacity(
                opacity: opacityPrecent.toDouble(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.walletName,
                              style: UITextStyle.subTitle(theme, color: theme.text600, fontWeight: FontWeight.w400)),
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
                      // SizedBox(
                      //   height: additionalSize,
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //         child: Container(
                      //           padding: const EdgeInsets.all(14.0),
                      //           width: double.infinity,
                      //           decoration: BoxDecoration(
                      //             color: const Color(0xff5e4300),
                      //             borderRadius: BorderRadius.circular(8),
                      //           ),
                      //           child: Text(
                      //             'Secure your assets, back up wallet now.',
                      //             style: UITextStyle.subTitle(
                      //               theme,
                      //               color: const Color(0xffe3c788),
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
            ),
          );
        },
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
