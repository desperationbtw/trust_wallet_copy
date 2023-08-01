import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/back/models/user.dart';
import 'package:trust_wallet_scm/presentation/rules_screen/rules_screen.dart';
import 'package:trust_wallet_scm/presentation/tech_screen/tech_screen.dart';
import 'package:trust_wallet_scm/presentation/welcome_screen/bloc/welcome_screen_bloc.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late WelcomeScreenBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = GetIt.I.get<WelcomeScreenBloc>();
    bloc.add(WelcomeScreenInitEvent());

    Future.delayed(Duration.zero, () {
      context.setLocale(const Locale('ru'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return BlocBuilder<WelcomeScreenBloc, WelcomeScreenState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is WelcomeScreenProcessingState) return const SizedBox.shrink();
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0.0, backgroundColor: theme.background),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 52.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Image.asset('assets/other/wallet.png', scale: 3),
                        onTap: () async {
                          final user = await PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const TechScreen(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );

                          if (user != null) {
                            bloc.add(WelcomeScreenInitEvent());
                          }
                        },
                      ),
                      Column(
                        children: [
                          Text(
                            'Конфиденциальный и безопасный'.tr(),
                            textAlign: TextAlign.center,
                            style: UITextStyle.custom(theme, fontSize: 28).copyWith(height: 1.2),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Приватные ключи никогда не покидют ваше устройство.'.tr(),
                            textAlign: TextAlign.center,
                            style: UITextStyle.custom(theme, fontSize: 15, color: theme.textBlue).copyWith(height: 1.2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(backgroundColor: theme.accent, radius: 4.0),
                          const SizedBox(width: 14.0),
                          const CircleAvatar(backgroundColor: Color(0xffdadada), radius: 4.0),
                          const SizedBox(width: 14.0),
                          const CircleAvatar(backgroundColor: Color(0xffdadada), radius: 4.0),
                          const SizedBox(width: 14.0),
                          const CircleAvatar(backgroundColor: Color(0xffdadada), radius: 4.0),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('СОЗДАТЬ НОВЫЙ КОШЕЛЕК').tr(),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    if (state is WelcomeScreenWaitState) return;
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const RulesScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },
                  child: const Text('У меня уже есть кошелек').tr(),
                ),
                const SizedBox(height: 50.0)
              ],
            ),
          ),
        );
      },
    );
  }
}
