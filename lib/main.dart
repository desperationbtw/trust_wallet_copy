import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:trust_wallet_scm/presentation/home_screen.dart';

import 'domain/di.dart';
import 'presentation/welcome_screen/welcome_screen.dart';
import 'uikit/uikit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DI.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      child: BlocProvider(
        create: (context) => UIThemeCubit(),
        child: BlocBuilder<UIThemeCubit, UIThemeState>(
          builder: (context, state) {
            return UITheme(
              theme: state.theme,
              child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Trust Wallet',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                  tabBarTheme: TabBarTheme(
                    indicatorColor: state.theme.accent,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  // highlightColor: state.theme.ui100.withOpacity(0.9),
                  // splashColor: state.theme.ui100.withOpacity(0.9),
                  colorScheme: ColorScheme.fromSwatch(
                    brightness: Brightness.dark,
                    backgroundColor: const Color(0xff1b1c1e),
                    cardColor: const Color(0xff252a30),
                    primarySwatch: Colors.blue,
                  ),
                  cardTheme: const CardTheme(
                    surfaceTintColor: Color(0xff252a30),
                  ),
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: state.theme.text800),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                      textStyle: MaterialStatePropertyAll(UITextStyle.subTitle(state.theme, fontWeight: FontWeight.w400)),
                      foregroundColor: const MaterialStatePropertyAll(Color(0xffa3c8fd)),
                    ),
                  ),
                  filledButtonTheme: FilledButtonThemeData(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                        textStyle: MaterialStatePropertyAll(UITextStyle.subTitle(state.theme)),
                        backgroundColor: const MaterialStatePropertyAll(Color(0xffa1c8ff)),
                        foregroundColor: const MaterialStatePropertyAll(Color(0xff191d20)),
                        padding: const MaterialStatePropertyAll(EdgeInsets.all(12.0))),
                  ),
                  listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0)),
                ),
                initialRoute: '/auth',
                routes: {
                  '/home': (context) => const HomeScreen(),
                  '/auth': (context) => const WelcomeScreen(),
                },
              ),
            );
          },
        ),
      ),
    ),
  );

  // initializeDateFormatting();
}
