import 'package:flutter/material.dart';
import 'package:portfolio/core/l10n/strings.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/components/hover_link.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(context.gutter / (context.isMobile ? 1 : 2)),
        padding: const EdgeInsets.all(AppSpace.x6),
        decoration: BoxDecoration(color: context.colors.surface, borderRadius: AppRadius.lgAll),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(child: Text('404', style: text.display)),
            const SizedBox(height: AppSpace.x4),
            Text(context.t(S.notFoundBody), style: text.bodyLarge.copyWith(color: context.colors.inkMuted)),
            const SizedBox(height: AppSpace.x8),
            HoverLink(label: context.t(S.backHome), icon: LinkIcon.back, to: '/'),
          ],
        ),
      ),
    );
  }
}
