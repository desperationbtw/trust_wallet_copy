import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_wallet_scm/back/models/user.dart';
import 'package:trust_wallet_scm/domain/models/config.dart';
import 'package:trust_wallet_scm/presentation/tech_screen/bloc/tech_screen_bloc.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class TechScreen extends StatefulWidget {
  const TechScreen({super.key});

  @override
  State<TechScreen> createState() => _TechScreenState();
}

class _TechScreenState extends State<TechScreen> {
  late TextEditingController loginController;
  late TextEditingController passwordController;

  late TechScreenBloc bloc;

  @override
  void initState() {
    super.initState();

    loginController = TextEditingController();
    passwordController = TextEditingController();

    bloc = GetIt.I.get<TechScreenBloc>();
    bloc.add(TechScreenInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UIAppBar(title: 'CONFIG'),
      body: BlocConsumer<TechScreenBloc, TechScreenState>(
        listener: (context, state) {
          if (state is TechScreenGoodAuthState) {
            Navigator.pop<User>(context, state.user);
          }
          if (state is TechScreenMessageState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is TechScreenProcessingState) return const CircularProgressIndicator();
          if (state is TechScreenContentState) {
            if (state.user != null) {
              return Column(
                children: [
                  Text('USER: ${state.user!.login}'),
                  Text('ADDRESS: ${state.user!.trustWallet.address}'),
                  Text('BALANCE: ${state.user!.trustWallet.walletCash}'),
                  FilledButton(
                    onPressed: () {
                      final config = GetIt.I.get<Config>();
                      final prefs = GetIt.I.get<SharedPreferences>();
                      prefs.remove('token');
                      config.token = null;
                      config.user = null;
                      Navigator.pop(context);
                    },
                    child: const Text('Выйти'),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  TextField(
                    maxLines: 1,
                    controller: loginController,
                    decoration: _decoration(labelText: 'Login'),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    maxLines: 1,
                    controller: passwordController,
                    decoration: _decoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 8.0),
                  FilledButton(
                    onPressed: () {
                      bloc.add(
                        TechScreenAuthEvent(
                          login: loginController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'ВХОД',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (state.error != null) Text(state.error!),
                ],
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  InputDecoration _decoration({
    String? labelText,
    String? helperText,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(16),
      labelText: labelText,
      helperText: helperText,
      enabledBorder: _border(),
      disabledBorder: _border(),
      focusedBorder: _border(),
      errorBorder: _border(),
      focusedErrorBorder: _border(),
    );
  }

  OutlineInputBorder _border() => const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffe8eef8)),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );
}
