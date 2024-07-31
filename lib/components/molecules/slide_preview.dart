import 'package:flutter/material.dart';

import '../../helpers/utils.dart';
import '../../providers/slide_provider.dart';
import '../../styles/style_util.dart';
import '../../superdeck.dart';
import '../atoms/markdown_viewer.dart';
import '../atoms/slide_view.dart';
import 'scaled_app.dart';
import 'split_view.dart';

class SlidePreview extends StatelessWidget {
  const SlidePreview(
    this.slide, {
    super.key,
  });

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final panelSize = SplitViewProvider.panelSizeOf(context);
    var paddingSize = panelSize / (context.isSmall ? 5.0 : 20.0);

    return Center(
      child: Container(
        margin: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          color: const Color.fromARGB(144, 0, 0, 0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ScaledWidget(
          child: SlideView(slide),
        ),
      ),
    );
  }
}

class SlideMarkdownPreview extends StatelessWidget {
  const SlideMarkdownPreview({
    super.key,
    required this.slide,
  });

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final rawYaml = slide.raw;
    final options = '#### Options\n```yaml\n${rawYaml.trim()}\n```\n';
    final data = '#### Content\n```markdown\n${slide.data}\n```\n';
    final s = SlideSpecUtility.self;
    return SpecBuilder(
      style: defaultStyle.merge(
        Style(
          s.code.textStyle.fontSize(14),
        ),
      ),
      builder: (mix) {
        return SlideConstraints(
          child: AnimatedMarkdownViewer(
            content: "$options\n$data\n",
            spec: SlideSpec.of(context),
            duration: Duration.zero,
          ),
        );
      },
    );
  }
}
