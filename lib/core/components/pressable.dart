import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/components/web_link.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

/// The one interactive surface of the redesign. It reports hover and focus
/// to [builder], draws a focus ring that follows [radius], answers Enter and
/// Space, shows the hand cursor and keeps the target at least 44 × 44.
///
/// With [to] it is a real browser link (see [WebLink]); without it, [onTap]
/// runs.
class Pressable extends StatefulWidget {
  final Widget Function(BuildContext context, bool hovered, bool focused) builder;
  final String? to;
  final VoidCallback? onTap;

  /// Read by screen readers; without it the child's own text is used.
  final String? semanticLabel;
  final bool isButton;
  final BorderRadius radius;

  const Pressable({
    super.key,
    required this.builder,
    this.to,
    this.onTap,
    this.semanticLabel,
    this.isButton = false,
    this.radius = const BorderRadius.all(Radius.circular(4)),
  });

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final to = widget.to;
    if (to == null) return _build(context, widget.onTap);
    return WebLink(to: to, builder: _build);
  }

  Widget _build(BuildContext context, VoidCallback? onTap) {
    return Semantics(
      link: !widget.isButton,
      button: widget.isButton,
      label: widget.semanticLabel,
      child: FocusableActionDetector(
        enabled: onTap != null,
        mouseCursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
        onShowHoverHighlight: (value) => setState(() => _hovered = value),
        onShowFocusHighlight: (value) => setState(() => _focused = value),
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
            onTap?.call();
            return null;
          }),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                borderRadius: widget.radius,
                border: _focused ? Border.all(color: context.colors.ink, width: 2) : null,
              ),
              child: widget.builder(context, _hovered, _focused),
            ),
          ),
        ),
      ),
    );
  }
}
