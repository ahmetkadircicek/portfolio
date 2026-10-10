import 'package:flutter/widgets.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:url_launcher/link.dart';

/// Makes [builder]'s widget a real link in the browser: an `<a>` sits on top,
/// so right-click "open in new tab", cmd/middle-click and the URL preview in
/// the status bar all work like on any website. Paths starting with `/` stay
/// in the app, in the page's language (`/contact` on a Turkish page goes to
/// `/tr/contact`); files (`/cv.pdf`) and anything else open in a new tab.
class WebLink extends StatelessWidget {
  final String to;
  final Widget Function(BuildContext context, VoidCallback? follow) builder;

  const WebLink({super.key, required this.to, required this.builder});

  bool get _internal => to.startsWith('/') && !to.split('/').last.contains('.');

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(_internal ? context.language.localize(to) : to),
      target: _internal ? LinkTarget.self : LinkTarget.blank,
      builder: (context, follow) => builder(context, follow == null ? null : () => follow()),
    );
  }
}
