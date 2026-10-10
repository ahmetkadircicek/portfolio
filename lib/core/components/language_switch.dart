import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/components/pressable.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:url_launcher/link.dart';

/// One button in the top bar showing the current language; each press opens
/// the same page in the next one (EN → TR → DE) and remembers the pick.
class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.language;
    final next = AppLanguage.values[(current.index + 1) % AppLanguage.values.length];
    final (_, path) = AppLanguage.split(GoRouterState.of(context).uri);
    return Semantics(
      button: true,
      label: '${context.t(S.language)}: ${current.nativeName}',
      excludeSemantics: true,
      child: Tooltip(
        message: next.nativeName,
        child: Link(
          uri: Uri.parse(next.localize(path)),
          builder: (context, follow) => Pressable(
            onPressed: () {
              LanguageManager.choose(next);
              follow?.call();
            },
            radius: AppRadius.pillAll,
            builder: (context, active) => AnimatedContainer(
              duration: AppMotion.base,
              curve: AppMotion.standard,
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.x3, vertical: 6),
              decoration: BoxDecoration(
                color: active ? context.colors.surface : context.colors.canvas,
                borderRadius: AppRadius.pillAll,
                border: Border.all(color: context.colors.line),
              ),
              child: Text(
                current.short,
                style: context.text.label.copyWith(color: context.colors.ink, fontWeight: FontWeight.w700),
              ),
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
