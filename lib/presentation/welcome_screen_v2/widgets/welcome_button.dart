import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class WelcomeButton extends StatelessWidget {
  final String header;
  final String footer;
  final VoidCallback onTap;
  final IconData icon;

  const WelcomeButton({
    super.key,
    required this.header,
    required this.footer,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UITheme.of(context);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));
    return Ink(
      decoration: BoxDecoration(
        color: theme.background,
        border: Border.all(
          color: theme.border,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(34.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: theme.circleBackground,
                            radius: 18.0,
                            child: Icon(icon, color: theme.text800, size: 24.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(header, style: UITextStyle.custom(theme, fontWeight: FontWeight.w500, color: theme.text800)),
                            Text(
                              footer,
                              style: UITextStyle.custom(theme, fontWeight: FontWeight.w400, fontSize: 14.0, color: theme.textGray, height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(UIIcons.kit_arrow_right, color: theme.text800),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
