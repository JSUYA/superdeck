import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers/controller.dart';
import '../../models/options_model.dart';
import '../../styles/style_spec.dart';
import '../atoms/markdown_viewer.dart';
import 'slide_view.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.data,
    required this.options,
    super.key,
  });

  final String data;
  final ContentOptions? options;

  @override
  Widget build(context) {
    final mix = MixProvider.of(context);
    final spec = SlideSpec.of(mix);
    final container = spec.contentContainer;
    final alignment = options?.alignment ?? ContentAlignment.center;

    final assets = SuperDeck.assetsOf(context);

    final constraints = SlideConstraints.of(context);

    return AnimatedMixedBox(
      duration: const Duration(milliseconds: 300),
      spec: spec.contentContainer.copyWith(
        alignment: alignment.toAlignment(),
      ),
      child: SingleChildScrollView(
        child: IntrinsicWidth(
          child: AnimatedMarkdownViewer(
            content: data,
            spec: spec,
            assets: assets,
            constraints: _calculateConstraints(constraints.biggest, container),
            duration: const Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }
}

BoxConstraints _calculateConstraints(Size size, BoxSpec spec) {
  final padding = spec.padding ?? EdgeInsets.zero;
  final margin = spec.margin ?? EdgeInsets.zero;

  double horizontalBorder = 0.0;
  double verticalBorder = 0.0;

  if (spec.decoration is BoxDecoration) {
    final border = (spec.decoration as BoxDecoration).border;
    if (border != null) {
      horizontalBorder = border.dimensions.horizontal;
      verticalBorder = border.dimensions.vertical;
    }
  }

  final horizontalSpacing =
      padding.horizontal + margin.horizontal + horizontalBorder;
  final verticalSpacing = padding.vertical + margin.vertical + verticalBorder;

  return BoxConstraints(
    maxHeight: size.height - verticalSpacing,
    maxWidth: size.width - horizontalSpacing,
  );
}
