import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app_notifier.dart';

/// App-wide providers. Page view models are provided by their own views so
/// their state starts fresh on every visit.
class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AppNotifier()),
  ];
}
