import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dash_deck_cli/src/builders/slide_data_builder.dart';
import 'package:dash_deck_cli/src/constants.dart';
import 'package:dash_deck_cli/src/helper/prompts/prompts_service.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:watcher/watcher.dart';

class BuildCommand extends Command<int> {
  BuildCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'watch',
        abbr: 'w',
        help:
            'Watches for changes in the slides.md file and rebuilds the slides',
        negatable: false,
      )
      ..addFlag(
        'path',
        abbr: 'p',
        help: 'The path to dashdeck directory',
        negatable: false,
      );
  }

  @override
  String get description => 'Builds the slides from the slides.md file';

  @override
  String get name => 'build';

  final Logger _logger;

  @override
  Future<int> run() async {
    final watch = argResults?['watch'] as bool;

    kDashDeckDirectory.rootDir = Directory(
      join(
        kWorkingDirectory.path,
      ),
    );

    Future<void> runBuildProcess() async {
      final progress = _logger.progress('Updating slides');

      try {
        final response = await PromptsService.createOutline(
          'How to prepare for a half IronMan!',
        );

        await storeSlideData(response);
      } catch (e, stackTrace) {
        progress.fail(
          'Failed to update slides',
        );
        _logger
          ..err(e.toString())
          ..detail(stackTrace.toString());

        return;
      }
    }

    // Run first build
    await runBuildProcess();

    if (watch) {
      _logger.info('Watching for changes...');

      final filesToWatch = [
        kDashDeckDirectory.markdownFile.path,
        kDashDeckDirectory.stylesFile.path,
      ];
      for (final filePath in filesToWatch) {
        final fileWatcher = FileWatcher(filePath);

        await for (final WatchEvent event in fileWatcher.events) {
          // Get name of file that changed
          final filePath = event.path;

          final fileName = basename(filePath);

          switch (event.type) {
            case ChangeType.MODIFY:
              _logger.info(
                'Changes detected in $fileName',
              );

              // Call your function to rebuild the slides
              // You can handle other change types as needed
              await runBuildProcess();
          }
        }
      }
    }
    return ExitCode.success.code;
  }
}
