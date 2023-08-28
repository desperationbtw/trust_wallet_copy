import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/back/models/user.dart';
import 'package:trust_wallet_scm/presentation/progress_screen/progress_screen.dart';
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
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 42.0),
                      Column(
                        children: [
                          Text(
                            'Приватность и безопасность'.tr(),
                            textAlign: TextAlign.center,
                            style: UITextStyle.custom(theme, fontSize: 28, color: theme.ui400).copyWith(height: 1.2),
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text(
                              'Приватные ключи всегда остаются на вашем устройстве.'.tr(),
                              textAlign: TextAlign.center,
                              style: UITextStyle.custom(theme, fontSize: 15, color: theme.ui400).copyWith(height: 1.2),
                            ),
                          ),
                          const SizedBox(height: 32.0),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 400), () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const ProgressScreen(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: const Text('Начать').tr(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(text: 'Нажимая "Начать", вы соглашетесь с нашими '),
                        TextSpan(text: 'Условия обслуживания', style: TextStyle(color: Color(0xffa4c8fc))),
                        TextSpan(text: ' и '),
                        TextSpan(text: 'Политика конфиденциальности', style: TextStyle(color: Color(0xffa4c8fc))),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: UITextStyle.custom(theme, fontSize: 13, color: theme.text400, height: 1.0),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
