import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:trust_wallet_scm/presentation/pin_screen/pin_screen.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.background,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Правовая информация', style: UITextStyle.custom(theme, fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                            child: Text(
                              'Пожалуйста, посмотрите Условия обслуживания и Политики конфиденциальности Trust Wallet.',
                              style: UITextStyle.custom(theme, fontSize: 12, color: const Color(0xffcac4d0)),
                            ),
                          ),
                          Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Политика Конфиденциальности',
                                        style: UITextStyle.custom(theme, fontSize: 14, color: const Color(0xff95a9c2)),
                                      ),
                                      const Icon(Icons.chevron_right, size: 32.0, color: Color(0xff68798d)),
                                    ],
                                  ),
                                ),
                                const Divider(indent: 16.0, color: Colors.black, height: 1.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Условия использования',
                                        style: UITextStyle.custom(theme, fontSize: 14, color: const Color(0xff95a9c2)),
                                      ),
                                      const Icon(Icons.chevron_right, size: 32.0, color: Color(0xff68798d)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: value,
                                  fillColor: const MaterialStatePropertyAll(Color(0xffa1c8ff)),
                                  checkColor: theme.background,
                                  onChanged: (_) {
                                    setState(() {
                                      value = !value;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    'Я прочитал и принимаю Условия обслуживания и Политику конфиденциальности.',
                                    style: UITextStyle.custom(theme, fontSize: 12, color: const Color(0xffa1c8ff), height: 1.2),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: value
                                  ? () {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const PinScreen(),
                                        withNavBar: false,
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );
                                    }
                                  : null,
                              style: value
                                  ? null
                                  : const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Color(0xff232f3d)),
                                      foregroundColor: MaterialStatePropertyAll(Color(0xff68798b))),
                              child: const Text('ПРОДОЛЖИТЬ'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
