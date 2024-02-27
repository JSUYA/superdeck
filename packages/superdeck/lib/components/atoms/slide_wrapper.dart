import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/scale.dart';

class SlideWrapper extends StatelessWidget {
  const SlideWrapper({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: kAspectRatio,
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          Scale.setupWith(Size(width, height), const Size(kWidth, kHeight));

          final maxWidth = Scale.scaleWidth(kWidth);
          final maxHeight = Scale.scaleHeight(kHeight);

          return Theme(
            data: scaleTheme(context),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                minWidth: maxWidth,
                maxHeight: maxHeight,
                minHeight: maxHeight,
              ).normalize(),
              child: child,
            ),
          );
        }),
      ),
    );
  }
}