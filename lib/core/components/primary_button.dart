import 'package:flutter/material.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Filled pill button with a trailing arrow. [inverted] is for dark
/// backgrounds.
class PrimaryButton extends StatefulWidget {
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
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final background = widget.inverted ? AppColors.canvas : AppColors.ink;
    final foreground = widget.inverted ? AppColors.ink : AppColors.onInk;
    final enabled = widget.onPressed != null && !widget.loading;

    final content = widget.loading
        ? SizedBox.square(dimension: 20, child: CircularProgressIndicator(color: foreground, strokeWidth: 2))
        : Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpace.x3,
            children: [
              Text(widget.label, style: context.text.link.copyWith(color: foreground, fontWeight: FontWeight.w600)),
              AnimatedSlide(
                offset: Offset(_hovering ? 0.25 : 0, 0),
                duration: AppMotion.base,
                curve: AppMotion.standard,
                child: Icon(Icons.arrow_forward, size: 18, color: foreground),
              ),
            ],
          );

    final button = AnimatedContainer(
      duration: AppMotion.base,
      curve: AppMotion.standard,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.x8),
      decoration: BoxDecoration(
        color: enabled || widget.loading ? background : background.withValues(alpha: 0.4),
        borderRadius: AppRadius.pillAll,
      ),
      alignment: Alignment.center,
      child: content,
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      excludeSemantics: true,
      child: HoverDetector(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: enabled ? widget.onPressed : null,
            child: widget.expand ? SizedBox(width: double.infinity, child: button) : IntrinsicWidth(child: button),
          ),
        ),
      ),
    );
  }
}
