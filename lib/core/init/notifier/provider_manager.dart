import 'package:portfolio/features/contact_me/viewmodel/contact_form_view_model.dart';
import 'package:portfolio/features/project_details/viewmodel/projects_viewmodel.dart' show ProjectsViewModel;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app_notifier.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AppNotifier()),
    ChangeNotifierProvider(create: (context) => ProjectsViewModel()),
    ChangeNotifierProvider(create: (context) => ContactFormViewModel()),
  ];
}
