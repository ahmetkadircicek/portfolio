import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/components/grid.dart';
import 'package:portfolio/core/data/figures.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/l10n/l10n.dart';
import 'package:portfolio/core/theme/app_tokens.dart';

/// A notebook's figures: rows on the 12-column grid on desktops, where the
/// figures of a row share its height, and one column below that.
class NotebookFigures extends StatelessWidget {
  final Notebook notebook;

  const NotebookFigures({super.key, required this.notebook});

  @override
  Widget build(BuildContext context) {
    if (!context.isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.x4,
        children: [
          for (final row in notebook.rows)
            for (final cell in row)
              for (final figure in cell.figures) FigureView(figure),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpace.x6,
      children: [for (final row in notebook.rows) _Row(row)],
    );
  }
}

class _Row extends StatelessWidget {
  final List<FigureCell> cells;

  const _Row(this.cells);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        const gap = AppLayout.columnGap;
        final column = (box.maxWidth - gap * (AppLayout.columns - 1)) / AppLayout.columns;
        var x = 0.0;
        final children = <Widget>[];
        for (final cell in cells) {
          final left = (cell.start - 1) * (column + gap);
          if (left > x) children.add(SizedBox(width: left - x));
          final width = GridRow.spanWidth(box.maxWidth, cell.span);
          children.add(SizedBox(
            width: width,
            child: cell.figures.length == 1
                ? FigureView(cell.figures.single)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: AppSpace.x6,
                    children: [for (final figure in cell.figures) FigureView(figure)],
                  ),
          ));
          x = left + width;
        }
        return IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: children));
      },
    );
  }
}

/// One figure in its frame: the caption line, then the drawing.
class FigureView extends StatelessWidget {
  final Figure figure;

  const FigureView(this.figure, {super.key});

  @override
  Widget build(BuildContext context) {
    final figure = this.figure;
    if (figure is TimelineFigure) return _Timeline(figure);
    final compact = context.isMobile;
    final colors = context.colors;
    final note = _note(context);
    final detail = compact ? figure.phoneDetail ?? figure.detail : figure.detail;
    final caption = DecoratedBox(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.ink.withValues(alpha: 0.12)))),
      child: Padding(
        padding: EdgeInsets.only(bottom: compact ? 10 : AppSpace.x3),
        child: _Ends(context.upper(context.t(figure.title)), context.upper(context.t(detail)), note),
      ),
    );
    final Widget drawing = switch (figure) {
      TimelineFigure() => const SizedBox(),
      FlowFigure() => _Flow(figure),
      TierFigure() => _Tiers(figure),
      GridFigure() => _Grid(figure),
      MapFigure() => _Map(figure),
      StepsFigure() => _Steps(figure),
      CalloutFigure() => _Callouts(figure),
      EstimateFigure() => _Estimate(figure),
      IconFigure() => _Icon(figure),
      ContrastFigure() => _Contrast(figure),
      TypeScaleFigure() => _TypeScale(figure),
    };
    return Semantics(
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.canvas,
          border: Border.all(color: colors.ink.withValues(alpha: 0.14)),
          borderRadius: BorderRadius.circular(compact ? 12 : 14),
        ),
        child: Padding(
          padding: EdgeInsets.all(compact ? AppSpace.x4 : AppSpace.x6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [caption, SizedBox(height: compact ? 14 : AppSpace.x5), drawing],
          ),
        ),
      ),
    );
  }
}

/// The small mono text of figures.
TextStyle _note(BuildContext context, [Color? color]) =>
    context.type.note.copyWith(color: color ?? context.colors.inkSubtle);

/// Mono text in ink at a readable size, e.g. a formula.
TextStyle _mono(BuildContext context, double size) =>
    context.type.note.copyWith(fontSize: size, letterSpacing: 0, color: context.colors.ink);

/// Two texts at the ends of a line.
class _Ends extends StatelessWidget {
  final String start;
  final String end;
  final TextStyle style;
  final TextStyle? endStyle;

  const _Ends(this.start, this.end, this.style, [this.endStyle]);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(start, style: style)),
        const SizedBox(width: AppSpace.x3),
        Flexible(child: Text(end, style: endStyle ?? style, textAlign: TextAlign.end)),
      ],
    );
  }
}

class _Box extends StatelessWidget {
  final FigureBox box;

  const _Box(this.box);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final colors = context.colors;
    final type = context.type;
    final note = _note(context, box.dark ? colors.onBlockMuted : null);
    final detail = compact ? box.phoneDetail ?? box.detail : box.detail;
    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: compact ? AppSpace.x3 : 14, vertical: compact ? 10 : AppSpace.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.x1,
        children: [
          if (box.kicker != null) Text(context.upper(context.t(box.kicker!)), style: note),
          Text(context.t(box.title),
              style: type.bodySmall
                  .copyWith(fontWeight: FontWeight.w600, height: 1.3, color: box.dark ? colors.onBlock : colors.ink)),
          if (detail != null) Text(context.t(detail), style: note),
        ],
      ),
    );
    if (box.dashed) {
      return CustomPaint(foregroundPainter: _Dashed(colors.ink, AppRadius.sm), child: content);
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: box.dark ? colors.block : colors.canvas,
        border: Border.all(color: box.dark ? colors.block : colors.ink),
        borderRadius: AppRadius.smAll,
      ),
      child: content,
    );
  }
}

/// Boxes side by side at the height of the tallest.
class _Side extends StatelessWidget {
  final List<Widget> children;
  final double gap;

  const _Side(this.children, {this.gap = AppSpace.x3});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: gap,
        children: [for (final child in children) Expanded(child: child)],
      ),
    );
  }
}

/// ↓ between two rows, with an optional label after it.
class _Down extends StatelessWidget {
  final L? label;

  const _Down([this.label]);

  @override
  Widget build(BuildContext context) {
    final label = this.label;
    return SizedBox(
      height: context.isMobile ? AppSpace.x6 : AppSpace.x7,
      child: Center(
        child: Text(label == null ? '↓' : '↓ ${context.t(label)}', style: _note(context, context.colors.ink)),
      ),
    );
  }
}

class _Flow extends StatelessWidget {
  final FlowFigure figure;

  const _Flow(this.figure);

  @override
  Widget build(BuildContext context) {
    final boxes = [for (final box in figure.boxes) _Box(box)];
    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, box) in boxes.indexed) ...[if (i > 0) const _Down(), box],
        ],
      );
    }
    final arrow = Center(child: Text('→', style: _mono(context, 14)));
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.x3,
        children: [
          for (final (i, box) in boxes.indexed) ...[if (i > 0) arrow, Expanded(child: box)],
        ],
      ),
    );
  }
}

class _Tiers extends StatelessWidget {
  final TierFigure figure;

  const _Tiers(this.figure);

  @override
  Widget build(BuildContext context) {
    final footnote = figure.footnote;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, (boxes, _)) in figure.tiers.indexed) ...[
          if (i > 0) _Down(figure.tiers[i - 1].$2),
          boxes.length == 1 ? _Box(boxes.single) : _Side([for (final box in boxes) _Box(box)]),
        ],
        if (footnote != null && !context.isMobile) ...[
          const SizedBox(height: AppSpace.x4),
          Text(context.t(footnote), style: _note(context)),
        ],
      ],
    );
  }
}

class _Grid extends StatelessWidget {
  final GridFigure figure;

  const _Grid(this.figure);

  @override
  Widget build(BuildContext context) {
    final boxes = figure.boxes;
    final footnote = figure.footnote;
    final gap = context.isMobile ? 10.0 : AppSpace.x3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: gap,
      children: [
        for (var i = 0; i < boxes.length; i += 2)
          _Side([_Box(boxes[i]), if (i + 1 < boxes.length) _Box(boxes[i + 1]) else const SizedBox()], gap: gap),
        if (footnote != null && !context.isMobile) Text(context.upper(context.t(footnote)), style: _note(context)),
      ],
    );
  }
}

class _Map extends StatelessWidget {
  final MapFigure figure;

  const _Map(this.figure);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.type.bodySmall;
    final rule = BorderSide(color: colors.ink.withValues(alpha: 0.12));
    final rows = figure.rows;
    Widget line(Widget child, {required bool last, double vertical = 14}) => DecoratedBox(
          decoration: BoxDecoration(border: Border(bottom: last ? BorderSide.none : rule)),
          child: Padding(padding: EdgeInsets.symmetric(vertical: vertical), child: child),
        );
    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, (event, who)) in rows.indexed)
            line(
              last: i == rows.length - 1,
              vertical: AppSpace.x3,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpace.x1,
                children: [
                  Text(context.t(event), style: text),
                  Text(context.upper('→ ${context.t(who)}'), style: _note(context)),
                ],
              ),
            ),
        ],
      );
    }
    Widget row(Widget event, Widget arrow, Widget who) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 14, child: event),
            SizedBox(width: AppSpace.x6, child: arrow),
            Expanded(flex: 10, child: who),
          ],
        );
    final note = _note(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(border: Border(bottom: rule)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: row(Text(context.upper(context.t(figure.header.$1)), style: note), const SizedBox(),
                Text(context.upper(context.t(figure.header.$2)), style: note)),
          ),
        ),
        for (final (i, (event, who)) in rows.indexed)
          line(
            last: i == rows.length - 1,
            row(Text(context.t(event), style: text), Text('→', style: _mono(context, 14)), Text(context.t(who), style: text)),
          ),
      ],
    );
  }
}

/// Screenshots are about half as wide as they are tall.
const _screenRatio = 0.49;

class _Steps extends StatelessWidget {
  final StepsFigure figure;

  const _Steps(this.figure);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final columns = compact ? figure.phoneColumns : figure.columns;
    final steps = figure.steps;
    final footnote = compact ? figure.phoneFootnote ?? figure.footnote : figure.footnote;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpace.x4,
      children: [
        for (var i = 0; i < steps.length; i += columns)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: compact ? 10 : AppSpace.x3,
            children: [
              for (var j = i; j < i + columns; j++)
                Expanded(
                  child: j >= steps.length
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppSpace.x2,
                          children: [
                            AspectRatio(
                              aspectRatio: _screenRatio,
                              child: Image.asset(steps[j].$1, fit: BoxFit.contain, semanticLabel: context.t(steps[j].$2)),
                            ),
                            Text(context.upper(context.t(steps[j].$2)), style: _note(context)),
                          ],
                        ),
                ),
            ],
          ),
        if (footnote != null) Text(context.t(footnote), style: _note(context)),
      ],
    );
  }
}

class _Callouts extends StatelessWidget {
  final CalloutFigure figure;

  const _Callouts(this.figure);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final colors = context.colors;
    final screen = compact ? 150.0 : 210.0;
    final overlap = compact ? 44.0 : 60.0;
    final labelWidth = compact ? 104.0 : 150.0;
    final height = screen / _screenRatio;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: screen,
            child: Image.asset(figure.image, fit: BoxFit.contain, semanticLabel: context.t(figure.title)),
          ),
          for (final (at, label, phoneLabel) in figure.callouts)
            Positioned(
              left: screen - overlap,
              right: 0,
              top: at * height,
              child: Row(
                spacing: AppSpace.x2,
                children: [
                  Expanded(child: ColoredBox(color: colors.ink, child: const SizedBox(height: 1))),
                  SizedBox(
                    width: labelWidth,
                    child: Text(context.upper(context.t(compact ? phoneLabel : label)), style: _note(context)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Estimate extends StatelessWidget {
  final EstimateFigure figure;

  const _Estimate(this.figure);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final colors = context.colors;
    final radius = compact ? 3.0 : 4.0;
    final top = BorderRadius.vertical(top: Radius.circular(radius));
    Widget bar(double value, Widget child) =>
        Expanded(child: FractionallySizedBox(heightFactor: value, child: child));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: compact ? 10 : 14,
      children: [
        Container(
          height: compact ? 110 : 150,
          padding: EdgeInsets.symmetric(horizontal: compact ? 6 : AppSpace.x2),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.ink))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: compact ? 10 : 14,
            children: [
              for (final value in figure.past)
                bar(value,
                    DecoratedBox(decoration: BoxDecoration(color: colors.ink.withValues(alpha: 0.16), borderRadius: top))),
              bar(
                figure.next,
                CustomPaint(
                  foregroundPainter: _Dashed(figure.color, radius, openBottom: true),
                  child: ColoredBox(color: figure.color.withValues(alpha: 0.06)),
                ),
              ),
            ],
          ),
        ),
        _Ends(context.upper(context.t(figure.legend.$1)), context.upper(context.t(figure.legend.$2)), _note(context),
            _note(context, figure.color)),
        Text(figure.formula, style: _mono(context, compact ? 13 : 14)),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final IconFigure figure;

  const _Icon(this.figure);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final colors = context.colors;
    final note = _note(context);
    final size = compact ? 160.0 : 220.0;
    // The record's diameter (62 %) above the icon and the label's below.
    Widget measure({required double inset, double? top, double? bottom}) => Positioned(
          left: inset,
          right: inset,
          top: top,
          bottom: bottom,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: colors.ink),
                right: BorderSide(color: colors.ink),
                bottom: top == null ? BorderSide.none : BorderSide(color: colors.ink),
                top: bottom == null ? BorderSide.none : BorderSide(color: colors.ink),
              ),
            ),
            child: const SizedBox(height: 9),
          ),
        );
    final icon = SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size * 0.22),
            child: Image.asset(figure.image, width: size, height: size, semanticLabel: context.t(figure.title)),
          ),
          if (!compact) ...[
            measure(inset: size * 0.19, top: -18),
            measure(inset: size * 0.42, bottom: -18),
          ],
        ],
      ),
    );
    final notes = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: compact ? 6 : 10,
      children: [
        for (final measure in figure.measures) Text(context.upper(context.t(measure)), style: note),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(AppSpace.x1)),
            child: SizedBox(
              height: compact ? 16 : 18,
              child: Row(children: [for (final c in figure.gradient) Expanded(child: ColoredBox(color: c))]),
            ),
          ),
        ),
        Text(context.upper(context.t(figure.gradientLabel)), style: note),
      ],
    );
    if (compact) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 14, children: [icon, notes]);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.x5),
      child: Row(spacing: AppSpace.x8, children: [icon, Flexible(child: notes)]),
    );
  }
}

/// Fonts only these figures use load when one first appears, not with the
/// site. Each is `assets/fonts/<family>/<Family>-Regular.ttf` and
/// `-SemiBold.ttf`.
final _figureFonts = <String, Future<void>>{};

Future<void> _loadFont(String family) => _figureFonts[family] ??= () async {
      final dir = 'assets/fonts/${family.toLowerCase()}';
      final loader = FontLoader(family)
        ..addFont(rootBundle.load('$dir/$family-Regular.ttf'))
        ..addFont(rootBundle.load('$dir/$family-SemiBold.ttf'));
      await loader.load();
    }();

/// [builder] again once [family] has loaded, so its text lays out anew in it.
class _InFont extends StatelessWidget {
  final String family;
  final WidgetBuilder builder;

  const _InFont(this.family, this.builder);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadFont(family),
      builder: (context, snapshot) => KeyedSubtree(
        key: ValueKey(snapshot.connectionState == ConnectionState.done),
        child: builder(context),
      ),
    );
  }
}

class _Contrast extends StatelessWidget {
  final ContrastFigure figure;

  const _Contrast(this.figure);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final colors = context.colors;
    return _InFont(
      figure.font,
      (context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: compact ? AppSpace.x3 : AppSpace.x4,
        children: [
          for (final (color, ratio, passes) in figure.swatches)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: compact ? AppSpace.x2 : 10,
                children: [
                  Container(
                    height: compact ? 96 : 148,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(compact ? 8 : 10)),
                    child: Text(figure.sample,
                        style: TextStyle(
                            fontFamily: figure.font,
                            fontWeight: FontWeight.w600,
                            fontSize: compact ? 15 : 17,
                            color: colors.onInk)),
                  ),
                  Text(
                    context.upper('#${color.toARGB32().toRadixString(16).substring(2)} + ${context.t(figure.textColor)}'),
                    style: _note(context),
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(text: '$ratio '),
                      TextSpan(
                          text: passes ? '✓' : '✕', style: TextStyle(color: passes ? colors.statusReady : colors.error)),
                    ]),
                    style: _mono(context, compact ? 16 : 20),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TypeScale extends StatelessWidget {
  final TypeScaleFigure figure;

  const _TypeScale(this.figure);

  @override
  Widget build(BuildContext context) {
    final compact = context.isMobile;
    final ink = context.colors.ink;
    return _InFont(
      figure.font,
      (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: compact ? AppSpace.x1 : 6,
        children: [
          for (final (name, size, spec, bold, onPhone) in figure.styles)
            if (onPhone || !compact)
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(name,
                        style: TextStyle(
                          fontFamily: figure.font,
                          // The largest styles step down on phones.
                          fontSize: compact && size > 22 ? size - (size - 22) / 3 : size,
                          fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                          height: 1.2,
                          color: ink,
                        )),
                  ),
                  Text(spec, style: _note(context)),
                ],
              ),
        ],
      ),
    );
  }
}

/// Fig. 0: the phases as one bar, a list on phones and tablets.
class _Timeline extends StatelessWidget {
  final TimelineFigure figure;

  const _Timeline(this.figure);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final note = _note(context);
    final bar = context.isDesktop;
    final rule = BorderSide(color: colors.ink.withValues(alpha: 0.2));
    final phases = figure.phases;
    const fills = [0.1, 0.06, 0.03];
    Widget phase(int i) {
      final (label, length) = phases[i];
      final last = i == phases.length - 1;
      final text = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpace.x3, vertical: bar ? 0 : math.max(10, length * 2.5).toDouble()),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(context.t(label), style: note, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      );
      if (last) return CustomPaint(painter: _Stripes(figure.color), child: text);
      return DecoratedBox(
        decoration: BoxDecoration(
          color: colors.ink.withValues(alpha: fills[i % fills.length]),
          border: bar ? Border(right: rule) : Border(bottom: rule),
        ),
        child: text,
      );
    }

    return Semantics(
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: bar ? 10 : AppSpace.x2,
        children: [
          _Ends(context.upper(context.t(figure.title)), context.upper(context.t(figure.detail)), note),
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(border: Border.fromBorderSide(rule), borderRadius: AppRadius.smAll),
            child: ClipRRect(
              borderRadius: AppRadius.smAll,
              child: bar
                  ? SizedBox(
                      height: AppSpace.x10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var i = 0; i < phases.length; i++) Expanded(flex: phases[i].$2, child: phase(i)),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [for (var i = 0; i < phases.length; i++) phase(i)],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A table under a chapter's text.
class ChapterTableView extends StatelessWidget {
  final ChapterTable table;

  const ChapterTableView(this.table, {super.key});

  @override
  Widget build(BuildContext context) {
    final table = this.table;
    return switch (table) {
      NumbersTable() => _Numbers(table),
      FormulaTable() => _Formulas(table),
    };
  }
}

class _Numbers extends StatelessWidget {
  final NumbersTable table;

  const _Numbers(this.table);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final rule = BorderSide(color: colors.ink.withValues(alpha: 0.12));
    final perRow = context.isDesktop ? table.numbers.length : 2;
    final numbers = table.numbers;
    Widget cell(int i) {
      final (label, value) = numbers[i];
      final first = i % perRow == 0;
      final last = i % perRow == perRow - 1;
      return DecoratedBox(
        decoration: BoxDecoration(border: Border(right: last ? BorderSide.none : rule)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(first ? 0 : AppSpace.x4, AppSpace.x4, last ? 0 : AppSpace.x4, AppSpace.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(context.upper(context.t(label)), style: _note(context)),
              Text(context.t(value),
                  style: type.lead.copyWith(fontSize: context.isMobile ? 30 : 34, height: 1.1)),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpace.x5,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(border: Border(top: rule)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < numbers.length; i += perRow)
                DecoratedBox(
                  decoration: BoxDecoration(border: Border(bottom: rule)),
                  child: _Side([for (var j = i; j < i + perRow && j < numbers.length; j++) cell(j)], gap: 0),
                ),
            ],
          ),
        ),
        Text(context.t(table.footnote), style: _note(context)),
      ],
    );
  }
}

class _Formulas extends StatelessWidget {
  final FormulaTable table;

  const _Formulas(this.table);

  @override
  Widget build(BuildContext context) {
    final rule = BorderSide(color: context.colors.ink.withValues(alpha: 0.12));
    final mobile = context.isMobile;
    final formula = _mono(context, mobile ? 13 : 14);
    return DecoratedBox(
      decoration: BoxDecoration(border: Border(top: rule)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (name, value) in table.rows)
            DecoratedBox(
              decoration: BoxDecoration(border: Border(bottom: rule)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpace.x3),
                child: mobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpace.x1,
                        children: [
                          Text(context.upper(context.t(name)), style: _note(context)),
                          Text(context.t(value), style: formula),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpace.x6,
                        children: [
                          SizedBox(
                            width: context.isDesktop ? 200 : 140,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(context.upper(context.t(name)), style: _note(context)),
                            ),
                          ),
                          Expanded(child: Text(context.t(value), style: formula)),
                        ],
                      ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A dashed outline with rounded corners; [openBottom] leaves out the
/// bottom edge, for a bar standing on an axis.
class _Dashed extends CustomPainter {
  final Color color;
  final double radius;
  final bool openBottom;

  const _Dashed(this.color, this.radius, {this.openBottom = false});

  @override
  void paint(Canvas canvas, Size size) {
    final r = Radius.circular(radius);
    final path = openBottom
        ? (Path()
          ..moveTo(0, size.height)
          ..lineTo(0, radius)
          ..arcToPoint(Offset(radius, 0), radius: r)
          ..lineTo(size.width - radius, 0)
          ..arcToPoint(Offset(size.width, radius), radius: r)
          ..lineTo(size.width, size.height))
        : (Path()..addRRect(RRect.fromRectAndRadius((Offset.zero & size).deflate(0.5), r)));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = openBottom ? 1.5 : 1;
    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 7) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_Dashed old) => old.color != color || old.radius != radius || old.openBottom != openBottom;
}

/// Diagonal stripes in [color]: work that is still going on.
class _Stripes extends CustomPainter {
  final Color color;

  const _Stripes(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, Paint()..color = color.withValues(alpha: 0.04));
    final stripe = Paint()..color = color.withValues(alpha: 0.16);
    const period = 12 * math.sqrt2;
    const width = 6 * math.sqrt2;
    for (var x = -size.height; x < size.width; x += period) {
      canvas.drawPath(
        Path()
          ..moveTo(x, size.height)
          ..lineTo(x + size.height, 0)
          ..lineTo(x + size.height + width, 0)
          ..lineTo(x + width, size.height)
          ..close(),
        stripe,
      );
    }
  }

  @override
  bool shouldRepaint(_Stripes old) => old.color != color;
}
