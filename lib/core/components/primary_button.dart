import 'package:flutter/material.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Filled pill button with a trailing arrow. [inverted] is for dark
/// backgrounds.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool inverted;
  final bool loading;
  final bool expand;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.inverted = false,
    this.loading = false,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = inverted ? context.colors.onBlock : context.colors.ink;
    final enabled = onPressed != null && !loading;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: Pressable(
        onPressed: enabled ? onPressed : null,
        radius: AppRadius.pillAll,
        ringColor: background,
        builder: (context, active) {
          final button = _button(context, active, enabled);
          return expand ? SizedBox(width: double.infinity, child: button) : IntrinsicWidth(child: button);
        },
      ),
    );
  }

  Widget _button(BuildContext context, bool active, bool enabled) {
    final background = inverted ? context.colors.onBlock : context.colors.ink;
    final foreground = inverted ? context.colors.block : context.colors.onInk;
    final content = loading
        ? SizedBox.square(dimension: 20, child: CircularProgressIndicator(color: foreground, strokeWidth: 2))
        : Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpace.x3,
            children: [
              Text(label, style: context.text.link.copyWith(color: foreground)),
              AnimatedSlide(
                offset: Offset(active ? 0.25 : 0, 0),
                duration: AppMotion.base,
                curve: AppMotion.standard,
                child: Icon(Icons.arrow_forward, size: 18, color: foreground),
              ),
            ],
          );

    return AnimatedContainer(
      duration: AppMotion.base,
      curve: AppMotion.standard,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.x8),
      decoration: BoxDecoration(
        color: enabled || loading ? background : background.withValues(alpha: 0.4),
        borderRadius: AppRadius.pillAll,
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
