import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/components/site_header.dart';
import 'package:portfolio/core/data/projects.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/features/project_details/widget/case_study_widget.dart';
import 'package:portfolio/features/project_details/widget/project_tabs_widget.dart';
import 'package:provider/provider.dart';
import '../viewmodel/projects_viewmodel.dart';

/// All project pages side by side; swipe or use the tabs to move between
/// them.
class ProjectsView extends StatelessWidget {
  final String? initialSlug;

  const ProjectsView({super.key, this.initialSlug});

  @override
  Widget build(BuildContext context) {
    final initial = Projects.all.indexWhere((p) => p.slug == initialSlug);
    return ChangeNotifierProvider(
      create: (_) => ProjectsViewModel(initialPage: initial < 0 ? 0 : initial),
      child: const _ProjectsPage(),
    );
  }
}

class _ProjectsPage extends StatelessWidget {
  const _ProjectsPage();

  void _onPageChanged(ProjectsViewModel viewModel, int page) {
    viewModel.setCurrentPage(page);
    // Keep the address bar shareable without pushing a history entry per swipe.
    SystemNavigator.routeInformationUpdated(uri: Uri.parse('/projects/${Projects.all[page].slug}'), replace: true);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectsViewModel>();
    final tabs = ProjectTabs(currentPage: viewModel.currentPage, onPageSelected: viewModel.goToPage);
    final mobile = context.isMobile;

    return Scaffold(
      body: Column(
        children: [
          SiteHeader(trailing: mobile ? null : tabs, bottom: mobile ? tabs : null),
          Expanded(
            child: PageView(
              controller: viewModel.pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (page) => _onPageChanged(viewModel, page),
              children: [
                for (var i = 0; i < Projects.all.length; i++) CaseStudy(project: Projects.all[i], index: i),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
