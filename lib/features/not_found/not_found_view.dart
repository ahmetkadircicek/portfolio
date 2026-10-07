import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        decoration: const BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.lgAll),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(child: Text('404', style: text.display)),
            const SizedBox(height: AppSpace.x4),
            Text('This page does not exist.', style: text.bodyLarge.copyWith(color: AppColors.inkMuted)),
            const SizedBox(height: AppSpace.x8),
            HoverLink(label: 'Back to home', icon: LinkIcon.back, onTap: () => context.go('/home')),
          ],
        ),
      ),
    );
  }
}
