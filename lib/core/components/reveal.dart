import 'package:flutter/material.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// Fades [child] in and lifts it into place the first time it scrolls into
/// view. Shows it at once when the visitor prefers reduced motion.
class Reveal extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const Reveal({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  static const _distance = 32.0;

  late final AnimationController _controller = AnimationController(vsync: this, duration: AppMotion.reveal);
  late final Animation<double> _progress = CurvedAnimation(parent: _controller, curve: AppMotion.emphasized);
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _controller.value = 1;
      _detach();
      return;
    }
    if (_controller.value > 0) return;
    final position = Scrollable.maybeOf(context)?.position;
    if (position != _position) {
      _detach();
      _position = position?..addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted || _controller.value > 0) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < context.height * 0.92) {
      _detach();
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  void _detach() {
    _position?.removeListener(_check);
    _position = null;
  }

  @override
  void dispose() {
    _detach();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FadeTransition sets the layer's opacity without rebuilding; only the
    // small translate is rebuilt per frame.
    return FadeTransition(
      opacity: _progress,
      child: AnimatedBuilder(
        animation: _progress,
        child: widget.child,
        builder: (context, child) =>
            Transform.translate(offset: Offset(0, _distance * (1 - _progress.value)), child: child),
      ),
    );
  }
}
