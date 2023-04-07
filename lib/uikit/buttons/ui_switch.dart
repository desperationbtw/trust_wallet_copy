import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

/// Переключатель типа Switch
class UISwitch extends StatefulWidget {
  /// Значение переключателя
  final bool value;

  /// Коллбек при изменении состояния
  final void Function(bool)? onChanged;

  const UISwitch({
    Key? key,
    this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  State<UISwitch> createState() => _UI2SwitchState();
}

class _UI2SwitchState extends State<UISwitch> with SingleTickerProviderStateMixin {
  late Animation _colorAnimation;
  late Animation _alignmentAnimation;
  late AnimationController _animationController;

  static const _switchHeight = 24.0;
  static const _switchWidth = 53.0;
  static const _switchDotSize = 20.0;
  static const _switchBorderRadius = 56.0;
  static const _switchAnimationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: _switchAnimationDuration,
    );
    if (widget.value) _animationController.value = 1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimation = ColorTween(
      begin: UITheme.of(context).ui300,
      end: UITheme.of(context).accent,
    ).animate(_animationController);

    _alignmentAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(UISwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _animateSwitch();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return _buildSwitch();
        });
  }

  Widget _buildSwitch() {
    return GestureDetector(
      onTap: () => widget.onChanged?.call(!widget.value),
      child: Align(
        child: Container(
          width: _switchWidth,
          height: _switchHeight,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(_switchBorderRadius),
          ),
          child: Align(
            alignment: _alignmentAnimation.value,
            child: Container(
              width: _switchDotSize,
              height: _switchDotSize,
              decoration: BoxDecoration(
                color: UITheme.of(context).background,
                borderRadius: BorderRadius.circular(_switchBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 0.3,
                    offset: const Offset(0, 1),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 0.2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _animateSwitch() {
    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
