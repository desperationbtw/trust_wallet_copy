import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/presentation/token_screen/token_screen.dart';
import 'package:trust_wallet_scm/presentation/wallet_screen/bloc/wallet_screen_bloc.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

import 'widgets/header_sliver.dart';
import 'widgets/token_tile.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with TickerProviderStateMixin {
  late WalletScreenBloc _bloc;
  @override
  void initState() {
    _bloc = GetIt.I.get<WalletScreenBloc>();
    _bloc.add(WalletScreenInitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return Scaffold(
      backgroundColor: theme.background,
      body: BlocBuilder<WalletScreenBloc, WalletScreenState>(
        bloc: _bloc,
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerScrolled) {
                return [
                  HeaderSliver(
                    walletName: state.walletName,
                    balance: state.balance,
                  ),
                ];
              },
              body: TabBarView(children: [
                Center(
                  child: Builder(
                    builder: (context) {
                      return RefreshIndicator(
                        backgroundColor: theme.ui100,
                        color: theme.text800,
                        strokeWidth: 2,
                        onRefresh: () {
                          return Future.wait([
                            Future(() => _bloc.add(WalletScreenInitEvent())),
                            Future.delayed(const Duration(milliseconds: 200)),
                          ]);
                        },
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  const SizedBox(height: 16.0),
                                  ...state.tokens
                                      .map(
                                        (e) => TokenTile(
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
                                      'Add Tokens',
                                      style: UITextStyle.custom(theme, fontSize: 16.0, color: theme.accent, fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Center(
                  child: Text('todo'),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
