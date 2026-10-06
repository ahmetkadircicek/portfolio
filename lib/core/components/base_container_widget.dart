import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants/padding_constants.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';

class BaseContainer extends StatefulWidget {
  final Color firstColor;
  final Color secondColor;
  final String topRightText;
  final Widget child;

  const BaseContainer({
    super.key,
    required this.firstColor,
    required this.secondColor,
    required this.child,
    required this.topRightText,
  });

  @override
  State<BaseContainer> createState() => _BaseContainerState();
}

class _BaseContainerState extends State<BaseContainer> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Tilt and hover zoom are mouse effects. On touch screens the tilt would
    // also follow the gyroscope and fight with scrolling.
    final interactive = context.isDesktop;
    final card = Stack(
      children: [
        MouseRegion(
          onEnter: interactive ? (_) => setState(() => _hovering = true) : null,
          onExit: interactive ? (_) => setState(() => _hovering = false) : null,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.firstColor, widget.secondColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: AnimatedScale(
              scale: interactive && _hovering ? 3.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: widget.child,
            ),
          ),
        ),
        Padding(
          padding: PaddingConstants.allMedium,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(32),
              ),
              padding: PaddingConstants.allSmall + PaddingConstants.symmetricHorizontalSmall,
              child: Text(
                widget.topRightText,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (!interactive) return card;
    return Tilt(
      shadowConfig: ShadowConfig(
        color: context.secondary,
      ),
      tiltConfig: const TiltConfig(angle: 3, enableGestureSensors: false),
      child: card,
    );
  }
}
