import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pin_plus_keyboard/package/controllers/pin_input_controller.dart';
import 'package:pin_plus_keyboard/pin_plus_keyboard.dart';
import 'package:trust_wallet_scm/presentation/impot_screen/import_screen.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  bool firstTry = true;
  late PinInputController pinInputController;
  late List<Map<Color, double>> _pinSizes;
  String text = '';

  @override
  void initState() {
    super.initState();

    _pinSizes = [
      {Colors.grey: 16},
      {Colors.grey: 16},
      {Colors.grey: 16},
      {Colors.grey: 16},
      {Colors.grey: 16},
      {Colors.grey: 16},
    ];

    pinInputController = PinInputController(length: 6);

    pinInputController.addListener(() {
      final isRemove = text.length > pinInputController.text.length;
      text = pinInputController.text;
      final index = isRemove ? pinInputController.text.length : pinInputController.text.length - 1;
      setState(() {
        if (pinInputController.text.length == 6) {
          if (firstTry) {
            setState(() {
              text = 'f';
              _pinSizes = [
                {Colors.grey: 16},
                {Colors.grey: 16},
                {Colors.grey: 16},
                {Colors.grey: 16},
                {Colors.grey: 16},
                {Colors.grey: 16},
              ];
              pinInputController.changeText('');
              firstTry = false;
            });
          } else {
            _pinSizes = [
              {const Color(0xff6cd9b2): 16},
              {const Color(0xff6cd9b2): 16},
              {const Color(0xff6cd9b2): 16},
              {const Color(0xff6cd9b2): 16},
              {const Color(0xff6cd9b2): 16},
              {const Color(0xff6cd9b2): 16},
            ];
            Future.delayed(const Duration(milliseconds: 400), () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const ImpotScreen(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            });
          }
        } else {
          if (isRemove) {
            _pinSizes[index] = {Colors.grey: 16};
          } else {
            _pinSizes[index] = {const Color(0xffa1c8ff): 44};
            Future.delayed(const Duration(milliseconds: 120), () {
              setState(() {
                _pinSizes[index] = {const Color(0xffa1c8ff): 16};
              });
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: theme.background,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firstTry ? 'Создайте секретный код' : 'Подтвердите секрктный код',
                style: UITextStyle.custom(theme, fontSize: 22, color: const Color.fromARGB(255, 235, 235, 235)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _pinSizes
                      .map(
                        (e) => SizedBox(
                          width: 32,
                          height: 50,
                          child: Center(
                            child: AnimatedContainer(
                              decoration: BoxDecoration(
                                color: e.keys.first,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              duration: const Duration(milliseconds: 240),
                              height: e.values.first,
                              width: e.values.first,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              PinPlusKeyBoardPackage(
                spacing: 10,
                pinInputController: pinInputController,
                btnTextColor: const Color(0xffcac4d0),
                btnHasBorder: false,
                keyboardMaxWidth: 100,
                keyboardVerticalSpacing: 16,
                isInputHidden: true,
                inputFillColor: Colors.transparent,
                inputBorderColor: Colors.transparent,
                inputHeight: 0,
                keyboardButtonShape: KeyboardButtonShape.circular,
                inputBorderRadius: BorderRadius.circular(24.0),
                backButton: Icon(
                  Icons.backspace_rounded,
                  size: 32,
                  color: pinInputController.text.isEmpty ? const Color.fromARGB(255, 104, 108, 112) : const Color(0xffcac4d0),
                ),
                doneButton: const Icon(
                  Icons.fingerprint_rounded,
                  size: 48,
                  color: Color.fromARGB(255, 104, 108, 112),
                ),
                keyboardFontSize: 34,
                onSubmit: () {},
                keyboardFontFamily: 'Roboto',
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Секретный код добавляет дополнительный уровень безопасности при использовании приложения',
                textAlign: TextAlign.center,
                style: UITextStyle.custom(theme,
                    fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 229, 226, 231), height: 1.2),
              ),
            ),
          )
        ],
      ),
    );
  }
}
