import 'package:flutter/material.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// One button in the top bar showing the current language; each press
/// moves to the next one (EN → TR → DE).
class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.language;
    final next = AppLanguage.values[(current.index + 1) % AppLanguage.values.length];
    return Semantics(
      button: true,
      label: '${context.t(S.language)}: ${current.nativeName}',
      excludeSemantics: true,
      child: Tooltip(
        message: next.nativeName,
        child: HoverDetector(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => LanguageManager.set(next),
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.x2),
              child: Text(current.short, style: context.text.label.copyWith(color: context.colors.ink)),
            ),
          ),
        ),
      ),
    );
  }
}

/// Controls shown in every top bar.
class TopControls extends StatelessWidget {
  const TopControls({super.key});

  @override
  Widget build(BuildContext context) {
    return const LanguageSwitch();
  }
}
