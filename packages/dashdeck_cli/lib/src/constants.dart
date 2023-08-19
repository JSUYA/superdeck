import 'dart:io';

import 'package:path/path.dart';

const String kMarkdownFileName = 'slides.md';
const String kStylesFileName = 'styles.dart';
const String kConfigFileName = 'config.yml';
const String kAppDirName = 'app';
const String kGeneratedCodePreviewFileName = 'code_preview.g.dart';
const String kGeneratedSlidesFileName = 'slides.g.dart';

final kWorkingDirectory = Directory.current;

DashDeckDirectory kDashDeckDirectory = DashDeckDirectory();

class DashDeckDirectory {
  DashDeckDirectory() : rootDir = kWorkingDirectory;

  Directory rootDir;

  File _getFile([
    String? path1,
    String? path2,
    String? path3,
  ]) {
    return File(
      join(
        rootDir.path,
        path1,
        path2,
        path3,
      ),
    );
  }

  Directory _getDirectory([
    String? path1,
    String? path2,
    String? path3,
  ]) {
    return Directory(
      join(
        rootDir.path,
        path1,
        path2,
        path3,
      ),
    );
  }

  File _getGeneratedFile(String fileName) {
    return _getFile(
      appLibDir.path,
      'generated',
      fileName,
    );
  }

  File get configFile => _getFile(kConfigFileName);
  File get markdownFile => _getFile(kMarkdownFileName);
  File get stylesFile => _getFile(kStylesFileName);

  Directory get appDir => _getDirectory(kAppDirName);
  Directory get appLibDir => _getDirectory(kAppDirName, 'lib');

  File get generatedCodePreviewFile => _getGeneratedFile(
        kGeneratedCodePreviewFileName,
      );
  File get generatedSlidesFile => _getGeneratedFile(
        kGeneratedSlidesFileName,
      );
}
