import 'package:flutter/material.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/components/site_nav.dart';
import 'package:portfolio/core/data/profile.dart';
import 'package:portfolio/core/data/work.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:portfolio/features/site/parts.dart';

/// Any address the site does not know: the shape again, a short note and
/// the ways back.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final mobile = context.isMobile;
    final height = (context.height - AppLayout.navHeight).clamp(560.0, double.infinity);

    final projects = Wrap(
      spacing: mobile ? AppSpace.x4 : AppSpace.x8,
      children: [
        for (final p in work)
          TextLink(label: p.name, to: p.path, style: type.lead.copyWith(fontSize: mobile ? 22 : 24)),
      ],
    );

    return SitePage(
      child: SizedBox(
        height: height,
        child: PageColumn(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ExcludeSemantics(
                      child: Image.asset(
                        'assets/images/common/shape.webp',
                        width: mobile ? 320 : 560,
                        height: mobile ? 320 : 560,
                        opacity: const AlwaysStoppedAnimation(0.35),
                        gaplessPlayback: true,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MonoLabel(context.t(Copy.error404)),
                        const SizedBox(height: AppSpace.x5),
                        Semantics(
                          header: true,
                          child: Text(context.t(Copy.nothingHere),
                              textAlign: TextAlign.center, style: type.quote.copyWith(fontSize: mobile ? 56 : 112)),
                        ),
                        const SizedBox(height: AppSpace.x5),
                        Text(context.t(Copy.notFoundBody),
                            textAlign: TextAlign.center, style: type.body.copyWith(color: colors.inkMuted)),
                        const SizedBox(height: AppSpace.x2),
                        TextLink(label: '← ${context.t(Copy.backHome)}', to: '/'),
                      ],
                    ),
                  ],
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.line))),
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpace.x3, bottom: AppSpace.x5),
                  child: mobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [MonoLabel(context.t(Copy.straightToProject)), projects],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [MonoLabel(context.t(Copy.straightToProject)), projects],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
