import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/presentation/welcome_screen_v2/wallet_screen_v2.dart';
import 'package:trust_wallet_scm/uikit/foundation/foundation.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const WelcomeScreenV2(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0, backgroundColor: theme.background),
      body: Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: CircularProgressIndicator(
            color: theme.accent,
            strokeWidth: 5.0,
          ),
        ),
      ),
    );
  }
}
