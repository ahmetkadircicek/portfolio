import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/components/hover_detector_widget.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/features/project_details/widget/state_tag_widget.dart';
import 'package:portfolio/features/project_details/widget/technology_tag_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class ProjectState {
  final String label;
  final Color color;
  final String? url;

  const ProjectState({
    required this.label,
    required this.color,
    this.url,
  });
}

class ProjectDetailsBaseWidget extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final List<String> technologyTags;
  final List<String> screenshotPaths;
  final List<ProjectState> states;

  const ProjectDetailsBaseWidget({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.technologyTags,
    required this.screenshotPaths,
    this.states = const [],
  });

  // Constructor for backward compatibility
  factory ProjectDetailsBaseWidget.singleState({
    Key? key,
    required String title,
    required String description,
    required String iconPath,
    required List<String> technologyTags,
    required List<String> screenshotPaths,
    String stateLabel = '',
    Color stateColor = Colors.green,
    String? stateUrl,
  }) {
    return ProjectDetailsBaseWidget(
      key: key,
      title: title,
      description: description,
      iconPath: iconPath,
      technologyTags: technologyTags,
      screenshotPaths: screenshotPaths,
      states: stateLabel.isNotEmpty ? [ProjectState(label: stateLabel, color: stateColor, url: stateUrl)] : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderSection(
            title: title,
            description: description,
            iconPath: iconPath,
            technologyTags: technologyTags,
            states: states,
          ),
          const SizedBox(height: 32),
          _ScreenshotRow(screenshotPaths: screenshotPaths),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final List<String> technologyTags;
  final List<ProjectState> states;

  const _HeaderSection({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.technologyTags,
    required this.states,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AppIcon(iconPath: iconPath),
        Expanded(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: context.onPrimary,
                      ),
                    ),
                  ),
                  ...states.map(
                    (state) => state.url != null
                        ? _ClickableStateTag(state: state)
                        : StateTagWidget(
                            label: state.label,
                            color: state.color,
                          ),
                  ),
                ],
              ),
              Text(
                description,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: context.onPrimary.withValues(alpha: 0.7),
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: technologyTags.map((tag) => TechnologyTagWidget(label: tag)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClickableStateTag extends StatefulWidget {
  final ProjectState state;

  const _ClickableStateTag({required this.state});

  @override
  State<_ClickableStateTag> createState() => _ClickableStateTagState();
}

class _ClickableStateTagState extends State<_ClickableStateTag> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final urlString = widget.state.url!;
        if (kIsWeb) {
          html.window.open(urlString, '_blank');
        } else {
          final Uri url = Uri.parse(urlString);
          try {
            await launchUrl(
              url,
              mode: LaunchMode.platformDefault,
            );
          } catch (e) {
            debugPrint('Could not launch $urlString: $e');
          }
        }
      },
      child: HoverDetector(
        child: StateTagWidget(
          label: widget.state.label,
          color: widget.state.color,
        ),
      ),
    );
  }
}

class _ScreenshotRow extends StatelessWidget {
  final List<String> screenshotPaths;

  const _ScreenshotRow({
    required this.screenshotPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: screenshotPaths
          .map(
            (path) => Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(path, fit: BoxFit.cover),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _AppIcon extends StatelessWidget {
  final String iconPath;

  const _AppIcon({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(iconPath, fit: BoxFit.cover),
    );
  }
}
