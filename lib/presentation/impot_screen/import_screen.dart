import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/domain/enum/import_options.dart';
import 'package:trust_wallet_scm/domain/models/import_variant.dart';
import 'package:trust_wallet_scm/presentation/impot_screen/bloc/import_bloc.dart';
import 'package:trust_wallet_scm/presentation/variant_screen/variant_screen.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class ImpotScreen extends StatefulWidget {
  const ImpotScreen({super.key});

  @override
  State<ImpotScreen> createState() => _ImpotScreenState();
}

class _ImpotScreenState extends State<ImpotScreen> {
  late ImportBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ImportBloc();
    _bloc.add(ImportInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UIAppBar(
        title: 'Импортировать',
        actions: [
          Icon(Icons.search),
          SizedBox(width: 16.0),
          Icon(Icons.info_outline),
          SizedBox(width: 16.0),
        ],
      ),
      body: BlocBuilder<ImportBloc, ImportState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ImportProgressState) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: [
              _ListItem(leading: 'assets/other/google_rounded.png', title: 'Востановление с помощью Google', onTap: () {}),
              const Divider(thickness: 0.2),
              _ListItem(
                  leading: 'assets/other/ic_launcher_round.webp',
                  title: 'Мульти-монетный кошелек',
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: VariantScreen(
                        variant: ImportVariant(
                          name: 'Импортировать Мульти-монетный кошелек',
                          logo: '',
                          options: {ImportOptions.phrase},
                        ),
                        hasTabs: false,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  }),
              const Divider(thickness: 0.2),
              ...state.variants.map(
                (e) => _ListItem(
                  leading: e.logo,
                  title: e.name,
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: VariantScreen(variant: e),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String leading;
  final String title;
  final VoidCallback? onTap;

  const _ListItem({
    required this.leading,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(21.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(leading, width: 42.0, height: 42.0),
        ),
      ),
      title: Text(
        title,
        style: UITextStyle.custom(theme, fontSize: 16.0),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
