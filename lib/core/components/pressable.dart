import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Anything that can be clicked: reachable with Tab, pressed with Enter or
/// Space, the hand cursor on hover. [builder] gets `active` while the
/// pointer is over it or it has keyboard focus, so hover and focus look the
/// same; keyboard focus also draws a ring around it in [ringColor].
class Pressable extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget Function(BuildContext context, bool active) builder;

  /// Shape of the control, for the ring to follow.
  final BorderRadius radius;

  /// Defaults to the palette's focus color; use the control's own light
  /// color on dark blocks.
  final Color? ringColor;

  /// Told when `active` changes, e.g. to dim the other rows of a list.
  final ValueChanged<bool>? onActiveChanged;

  const Pressable({
    super.key,
    required this.onPressed,
    required this.builder,
    this.radius = AppRadius.smAll,
    this.ringColor,
    this.onActiveChanged,
  });

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _hovered = false;
  bool _focused = false;

  bool get _active => _hovered || _focused;

  void _set({bool? hovered, bool? focused}) {
    final was = _active;
    setState(() {
      _hovered = hovered ?? _hovered;
      _focused = focused ?? _focused;
    });
    if (_active != was) widget.onActiveChanged?.call(_active);
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = widget.onPressed;
    const outset = AppFocus.gap + AppFocus.width;
    return FocusableActionDetector(
      enabled: onPressed != null,
      mouseCursor: onPressed != null ? SystemMouseCursors.click : MouseCursor.defer,
      onShowHoverHighlight: (value) => _set(hovered: value),
      onShowFocusHighlight: (value) => _set(focused: value),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
          onPressed?.call();
          return null;
        }),
      },
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            widget.builder(context, _active),
            if (_focused)
              Positioned(
                left: -outset,
                top: -outset,
                right: -outset,
                bottom: -outset,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: widget.radius + const BorderRadius.all(Radius.circular(outset)),
                      border: Border.all(color: widget.ringColor ?? context.colors.focus, width: AppFocus.width),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
