import 'package:flutter/material.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// What I do, drawn from the technologies used across the projects.
class CapabilitiesSection extends StatelessWidget {
  const CapabilitiesSection({super.key});

  static const _items = [
    (
      'Cross-platform apps',
      'Android and iOS apps from one Flutter codebase, structured with MVVM and Provider.',
      'Flutter · Dart · Provider · MVVM',
    ),
    (
      'Native iOS',
      'Swift apps built with UIKit, Storyboard and Auto Layout, following Apple\'s design guidelines.',
      'Swift · UIKit · Lottie · Alamofire',
    ),
    (
      'Backend & integrations',
      'Cloud data, authentication, AI services, NFC and monetization wired into the app.',
      'Firebase · REST API · OAuth · Gemini AI · AdMob',
    ),
    (
      'Product design',
      'Research and interface design before the first line of code.',
      'Figma · Photoshop · Illustrator · Blender',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final columns = context.isDesktop ? 4 : (context.isTablet ? 2 : 1);
    return PageFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Reveal(child: SectionHeader(title: 'What I do', count: _items.length.toString().padLeft(2, '0'))),
          if (context.isMobile)
            // Phones get a short list: the title and its tools.
            for (final item in _items) ...[
              Reveal(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.x4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpace.x1,
                    children: [
                      Text(item.$1, style: text.title),
                      Text(item.$3, style: text.bodySmall.copyWith(color: context.colors.inkMuted)),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, thickness: 1, color: context.colors.line),
            ]
          else ...[
            const SizedBox(height: AppSpace.x8),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = AppSpace.x8;
                final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: AppSpace.x12,
                  children: [
                    for (var i = 0; i < _items.length; i++)
                      SizedBox(
                        width: width,
                        child: Reveal(
                          delay: Duration(milliseconds: 80 * (i % columns)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Eyebrow((i + 1).toString().padLeft(2, '0')),
                              const SizedBox(height: AppSpace.x6),
                              Text(_items[i].$1, style: text.h3),
                              const SizedBox(height: AppSpace.x2),
                              Text(_items[i].$2, style: text.body.copyWith(color: context.colors.inkMuted)),
                              const SizedBox(height: AppSpace.x4),
                              Text(_items[i].$3, style: text.bodySmall.copyWith(color: context.colors.inkSubtle)),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
