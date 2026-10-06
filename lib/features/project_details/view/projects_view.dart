import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding_constants.dart';
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
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProjectsViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          ProjectsNavigationBarWidget(
            currentPage: viewModel.currentPage,
            onPageSelected: viewModel.goToPage,
          ),
          Expanded(
            child: Container(
              margin: PaddingConstants.allLarge + PaddingConstants.symmetricHorizontalLarge,
              child: PageView(
                clipBehavior: Clip.none,
                controller: viewModel.pageController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                onPageChanged: viewModel.setCurrentPage,
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
