import 'package:flutter/material.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/components/theme_toggle.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// EN · TR · DE in the top bar; the active one in ink, the others muted.
class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.language;
    final style = context.text.label;
    return Semantics(
      label: context.t(S.language),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, language) in AppLanguage.values.indexed) ...[
            if (i > 0) Text('·', style: style.copyWith(color: context.colors.inkSubtle)),
            Semantics(
              button: true,
              selected: language == current,
              label: language.nativeName,
              excludeSemantics: true,
              child: HoverDetector(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => LanguageManager.set(language),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.x2, vertical: AppSpace.x2),
                    child: Text(
                      language.short,
                      style: style.copyWith(color: language == current ? context.colors.ink : context.colors.inkSubtle),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Language and theme controls, the same in every top bar.
class TopControls extends StatelessWidget {
  const TopControls({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpace.x2,
      children: [LanguageSwitch(), ThemeToggle()],
    );
  }
}
