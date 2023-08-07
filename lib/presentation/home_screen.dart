import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/presentation/settings_screen.dart';
import 'package:trust_wallet_scm/presentation/wallet_screen/wallet_screen.dart';
import 'package:trust_wallet_scm/presentation/welcome_screen_v2/wallet_screen_v2.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom + 12;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: theme.background, surfaceTintColor: theme.background),
      body: Container(
        color: theme.ui100,
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: SafeArea(
          child: PersistentTabView.custom(
            context,
            screens: const [
              // WalletScreen(),
              WelcomeScreenV2(),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
            ],
            controller: _controller,
            itemCount: 5,
            backgroundColor: theme.ui100,
            onWillPop: (_) {
              return Future.value(true);
            },
            customWidget: CustomNavBarWidget(
              selectedIndex: _controller.index,
              items: [
                UIBottomNavigationItem(
                  iconData: UIIcons.ic_wallet,
                  title: ("Кошелек"),
                ),
                UIBottomNavigationItem(
                  iconData: Icons.swap_horiz_sharp,
                  title: ("Своп"),
                ),
                UIBottomNavigationItem(
                  iconData: UIIcons.ic_discover,
                  title: ("Подробнее"),
                ),
                UIBottomNavigationItem(
                  iconData: UIIcons.ic_dapps,
                  title: ("Браузер"),
                ),
                UIBottomNavigationItem(
                  iconData: UIIcons.settings,
                  title: ("Настройки"),
                ),
              ],
              onItemSelected: (_) {},
            ),
          ),
        ),
      ),
    );
  }
}
