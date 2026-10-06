import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/features/project_details/view/peasy_project_details_page_widget.dart';
import 'package:portfolio/features/project_details/view/travelai_project_details_page_widget.dart';
import 'package:portfolio/features/project_details/view/tunes_project_details_page_widget.dart';
import 'package:portfolio/features/project_details/view/sevkiyatvar_project_details_page_widget.dart';
import 'package:portfolio/features/project_details/view/vilsa_project_details_page_widget.dart';
import 'package:portfolio/features/project_details/view/visiostellar_project_details_page_widget.dart';
import 'package:portfolio/features/project_details/widget/projects_navigation_bar_widget.dart';
import 'package:provider/provider.dart';
import '../viewmodel/projects_viewmodel.dart';

class ProjectsView extends StatelessWidget {
  /// Route segments, in page order: `/projects/<slug>`.
  static const slugs = ['tunes', 'vilsa', 'sevkiyatvar', 'travelai', 'visiostellar', 'peasy'];
  static const titles = ['Tunes', 'Vilsa', 'Sevkiyatvar', 'Travelai', 'Visiostellar', 'Peasy'];

  final String? initialSlug;

  const ProjectsView({super.key, this.initialSlug});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectsViewModel(initialPage: slugs.indexOf(initialSlug ?? slugs.first).clamp(0, slugs.length - 1)),
      child: const _ProjectsPage(),
    );
  }
}

class _ProjectsPage extends StatelessWidget {
  const _ProjectsPage();

  void _onPageChanged(BuildContext context, ProjectsViewModel viewModel, int page) {
    viewModel.setCurrentPage(page);
    // Keep the address bar shareable without pushing a history entry per swipe.
    SystemNavigator.routeInformationUpdated(uri: Uri.parse('/projects/${ProjectsView.slugs[page]}'), replace: true);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectsViewModel>();
    return Scaffold(
      body: Column(
        children: [
          ProjectsNavigationBarWidget(
            titles: ProjectsView.titles,
            currentPage: viewModel.currentPage,
            onPageSelected: viewModel.goToPage,
          ),
          Expanded(
            child: Container(
              margin: context.pageMargin,
              child: PageView(
                clipBehavior: Clip.none,
                controller: viewModel.pageController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (page) => _onPageChanged(context, viewModel, page),
                children: const [
                  TunesProjectDetailsView(),
                  VilsaProjectDetailsView(),
                  SevkiyatvarProjectDetailsView(),
                  TravelAIProjectDetailsView(),
                  VisiostellarProjectDetailsView(),
                  PeasyProjectDetailsView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
