import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/presentation/settings_screen.dart';
import 'package:trust_wallet_scm/presentation/wallet_screen/wallet_screen.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Widget> _pages;
  late final List<UIBottomNavigationItem> _navBarItems;
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _pages = [
      const WalletScreen(),
      const Center(child: Text('ahrip loh', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
      const Center(child: Text('ahrip loh', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
      const SettingsScreen(),
    ];
    _navBarItems = [
      UIBottomNavigationItem(
        iconData: UIIcons.ic_wallet,
        title: ("Кошелек"),
      ),
      UIBottomNavigationItem(
        iconData: UIIcons.ic_discover,
        title: ("Обзор"),
      ),
      UIBottomNavigationItem(
        iconData: UIIcons.ic_dapps,
        title: ("Браузер"),
      ),
      UIBottomNavigationItem(
        iconData: UIIcons.settings,
        title: ("Настройки"),
      ),
    ];

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
            screens: _pages,
            controller: _controller,
            itemCount: _navBarItems.length,
            backgroundColor: theme.ui100,
            onWillPop: (_) {
              return Future.value(true);
            },
            customWidget: CustomNavBarWidget(
              selectedIndex: _controller.index,
              items: _navBarItems,
              onItemSelected: (index) {
                // setState(() {
                //   _controller.index = index;
                // });
              },
            ),
          ),
        ),
      ),
    );
  }
}
