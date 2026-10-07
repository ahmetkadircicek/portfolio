import 'package:flutter/material.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/theme_manager.dart';

/// Sun or moon in the top bar; switches between light and dark mode.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final label = context.t(dark ? S.toLight : S.toDark);
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Tooltip(
        message: label,
        child: HoverDetector(
          child: GestureDetector(
            onTap: () => ThemeManager.toggle(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  size: 20, color: context.colors.ink),
            ),
          ),
        ),
      ),
    );
  }
}
