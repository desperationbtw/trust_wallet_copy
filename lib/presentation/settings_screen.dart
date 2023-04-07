import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _indent = 56.0;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UIThemeCubit>();
    final theme = UITheme.of(context);

    return Scaffold(
      backgroundColor: theme.background,
      appBar: const UIAppBar(title: 'Настройки'),
      body: BlocBuilder<UIThemeCubit, UIThemeState>(
        bloc: cubit,
        builder: (context, state) {
          return ListView(
            children: [
              Container(height: 8.0, width: double.infinity, color: theme.ui300),
              UIListTile(
                lable: 'Кошельки',
                leading: const SettingsIcon(icon: Icons.wallet, color: Color(0xFF31ba38)),
                hasDivider: false,
                action: Text(
                  'Основной Кошелёк 1',
                  style: UITextStyle.caption(theme),
                ),
              ),
              const SizedBox(height: 12.0),
              UIListTile(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                lable: 'Темный режим',
                leading: const SettingsIcon(icon: Icons.dark_mode, color: Color(0xFF1c1f24)),
                onTap: () {
                  cubit.selectTheme(state.theme.type == UIThemeType.light ? UIThemeType.dark : UIThemeType.light);
                },
                hasDivider: false,
                action: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Switch(
                    value: state.theme.type == UIThemeType.dark,
                    onChanged: (v) {
                      cubit.selectTheme(v ? UIThemeType.dark : UIThemeType.light);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              const UIListTile(lable: 'Уведомления о цене', leading: SettingsIcon(icon: Icons.monetization_on, color: Color(0xFFff5f53))),
              const UIListTile(lable: 'Контактные данные', leading: SettingsIcon(icon: Icons.person_2, color: Color(0xFF00FF00))),
              const UIListTile(lable: 'Сканировать QR-код', leading: SettingsIcon(icon: Icons.qr_code, color: Color(0xFF1b77fe))),
              const UIListTile(
                  lable: 'WalletConnect', leading: SettingsIcon(icon: Icons.web_asset, color: Color(0xFF3b99fb)), hasDivider: false),
              const SizedBox(height: 12.0),
              const UIListTile(lable: 'Общие Настройки', leading: SettingsIcon(icon: Icons.settings, color: Color(0xFF32bda6))),
              const UIListTile(lable: 'Безопасность', leading: SettingsIcon(icon: Icons.lock, color: Color(0xFF8e8d93))),
              const UIListTile(
                  lable: 'Push-уведомления',
                  leading: SettingsIcon(icon: Icons.notifications, color: Color(0xFFff3e2d)),
                  hasDivider: false),
              const SizedBox(height: 12.0),
              const UIListTile(lable: 'Центр поддержки', leading: SettingsIcon(icon: Icons.info, color: Color(0xFFf6b853))),
              const UIListTile(
                  lable: 'О приложении', leading: SettingsIcon(icon: Icons.heart_broken, color: Color(0xFFff56a7)), hasDivider: false),
              const SizedBox(height: 12.0),
              const UIListTile(lable: 'Twitter', leading: SettingsIcon(icon: Icons.square, color: Color(0xFF5baced))),
              const UIListTile(lable: 'Telegram', leading: SettingsIcon(icon: Icons.telegram, color: Color(0xFF36aee2))),
              const UIListTile(lable: 'Facebook', leading: SettingsIcon(icon: Icons.facebook, color: Color(0xFF3a579b))),
              const UIListTile(lable: 'Reddit', leading: SettingsIcon(icon: Icons.reddit, color: Color(0xFFff5700))),
              const UIListTile(lable: 'YouTube', leading: SettingsIcon(icon: Icons.square, color: Color(0xFFfe0000)), hasDivider: false),
            ],
          );
        },
      ),
    );
  }
}

class SettingsIcon extends StatelessWidget {
  final Color color;
  final IconData icon;

  const SettingsIcon({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}
