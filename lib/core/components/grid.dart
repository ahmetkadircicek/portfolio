import 'package:flutter/widgets.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// The redesign's content column: the page gutter on both sides and at most
/// [AppLayout.pageWidth] wide including it.
class PageColumn extends StatelessWidget {
  final Widget child;

  const PageColumn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final gutter = context.gutter;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gutter),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.pageWidth - 2 * AppSpace.x12),
          child: child,
        ),
      ),
    );
  }
}

/// One cell of a [GridRow]: starts at column [start] (1-based) and spans
/// [span] of the 12 columns.
class GridCell {
  final int start;
  final int span;
  final Widget child;

  const GridCell({required this.start, required this.span, required this.child});
}

/// A row on the 12-column grid. Cells must be in order and must not
/// overlap.
class GridRow extends StatelessWidget {
  final List<GridCell> cells;
  final CrossAxisAlignment crossAxisAlignment;

  const GridRow({super.key, required this.cells, this.crossAxisAlignment = CrossAxisAlignment.start});

  /// Width of [span] columns at a total width of [width].
  static double spanWidth(double width, int span) {
    const gap = AppLayout.columnGap;
    final column = (width - gap * (AppLayout.columns - 1)) / AppLayout.columns;
    return column * span + gap * (span - 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        const gap = AppLayout.columnGap;
        final column = (box.maxWidth - gap * (AppLayout.columns - 1)) / AppLayout.columns;
        // Each cell's left edge sits at (start - 1) × (column + gap).
        var x = 0.0;
        final children = <Widget>[];
        for (final cell in cells) {
          final left = (cell.start - 1) * (column + gap);
          if (left > x) children.add(SizedBox(width: left - x));
          final width = spanWidth(box.maxWidth, cell.span);
          children.add(SizedBox(width: width, child: cell.child));
          x = left + width;
        }
        return Row(crossAxisAlignment: crossAxisAlignment, children: children);
      },
    );
  }
}
