import 'package:flutter/material.dart';

class ProjectsViewModel extends ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void setCurrentPage(int page) {
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }
}
