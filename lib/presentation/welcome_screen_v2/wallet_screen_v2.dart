import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/presentation/token_screen/token_screen.dart';
import 'package:trust_wallet_scm/presentation/welcome_screen_v2/bloc/wallet_screen_v2_bloc.dart';
import 'package:trust_wallet_scm/presentation/welcome_screen_v2/widgets/welcome_button.dart';
import 'package:trust_wallet_scm/presentation/widgets/token_tile_view.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class WelcomeScreenV2 extends StatefulWidget {
  const WelcomeScreenV2({super.key});

  @override
  State<WelcomeScreenV2> createState() => _WelcomeScreenV2State();
}

class _WelcomeScreenV2State extends State<WelcomeScreenV2> with TickerProviderStateMixin {
  late WelcomeScreenV2Bloc _bloc;
  @override
  void initState() {
    _bloc = GetIt.I.get<WelcomeScreenV2Bloc>();
    _bloc.add(WelcomeScreenV2InitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    return Scaffold(
      body: PersistentTabView.custom(
        context,
        screens: [
          Scaffold(
            backgroundColor: theme.background,
            body: BlocBuilder<WelcomeScreenV2Bloc, WelcomeScreenV2State>(
              bloc: _bloc,
              builder: (context, state) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0),
                                child: Image.asset('assets/other/logo.png', scale: 3),
                              ),
                              Text(
                                'TRUST',
                                textAlign: TextAlign.center,
                                style: UITextStyle.custom(theme, color: theme.text400, fontSize: 24.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  'Присоединяйтесь к более чем 60 миллионам людей, которые создают\nбудущее Интернет вместе с нами',
                                  textAlign: TextAlign.center,
                                  style: UITextStyle.subTitle(theme, color: theme.text400).copyWith(fontSize: 16.0),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              WelcomeButton(
                                header: 'У меня нет кошелька',
                                footer: 'Создать\nмультичейн-кошелек',
                                onTap: () {},
                                icon: Icons.add,
                              ),
                              const SizedBox(height: 16.0),
                              WelcomeButton(
                                header: 'У меня уже есть кошелек',
                                footer: 'Импортировать кошелек',
                                onTap: () {},
                                icon: UIIcons.kit_arrow_down,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text('Популярныйе токены', style: UITextStyle.subTitle(theme, color: theme.text400)),
                    ),
                    if (state is! WelcomeScreenV2ContentState) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 100.0),
                        child: Image.asset('assets/truster/modal_trusty_social.webp', scale: 1),
                      ),
                      Text('Популярныйе токены', style: UITextStyle.title(theme, color: theme.text400)),
                    ] else
                      ...state.tokens
                          .map(
                            (e) => TokenTileView(
                              token: e,
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: TokenScreen(
                                    token: e,
                                  ),
                                  withNavBar: true,
                                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                );
                              },
                            ),
                          )
                          .toList(),
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(21.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: theme.accent,
                              radius: 10.0,
                              child: Icon(Icons.add, color: theme.background, size: 16.0),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Добавить токены',
                        style: UITextStyle.custom(theme, fontSize: 16.0, color: theme.accent, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const Text(''),
          const Text(''),
          const Text(''),
          const Text(''),
        ],
        controller: PersistentTabController(initialIndex: 0),
        itemCount: 5,
        backgroundColor: theme.ui100,
        onWillPop: (_) {
          return Future.value(true);
        },
        customWidget: CustomNavBarWidget(
          selectedIndex: 0,
          items: [
            UIBottomNavigationItem(
              iconData: UIIcons.ic_wallet,
              title: ("Кошелек"),
            ),
            UIBottomNavigationItem(
              iconData: UIIcons.ic_dex,
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
    );
  }
}
